import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:test/logic/authcubit/signup_cubit/signup_state.dart';


class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  // Firebase & Firestore
  final _auth = FirebaseAuth.instance;
  final _db   = FirebaseFirestore.instance;

  // In-flight data
  String? _pendingCode;
  late String name;
  late String email;
  late String password;

  /// STEP 1: Send (or resend) the 4-digit code via Gmail SMTP.
  Future<void> sendCode({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegistrationLoading());

    this.name     = name;
    this.email    = email;
    this.password = password;

    // generate new random 4-digit code
    _pendingCode = List.generate(4, (_) => Random().nextInt(10)).join();

    try {
      // using mailer’s gmail() helper; requires 2FA + App Password
      final username    =  dotenv.env['GMAIL_MAIL'] ?? '';           
      final appPassword = dotenv.env['GMAIL_PASSWORD'] ?? '';      
      final smtpServer  = gmail(username, appPassword);

      final message = Message()
        ..from =  Address(username, 'Education App')
        ..recipients.add(email)
        ..subject = 'Your verification code'
        ..text    = 'Your 4-digit code is $_pendingCode';

      await send(message, smtpServer);
      emit(RegistrationCodeSent());
    } on MailerException catch (e) {
    final problems = e.problems.map((p) => p.msg).join('\n');
      emit(RegistrationFailure('Email send failed:\n$problems'));
    } catch (e) {
      emit(RegistrationFailure('Unexpected error sending email: $e'));
    }
  }

  /// STEP 2: Verify the code, then create the user & Firestore entry.
  Future<void>  verifyCode(String inputCode) async {
    if (_pendingCode == null) {
      emit(const RegistrationFailure('No code has been sent yet.'));
      return;
    }
    if (inputCode != _pendingCode) {
      emit(const RegistrationFailure('Verification code does not match.'));
      return;
    }

    emit(RegistrationLoading());
    try {
  
      final cred = await _auth.createUserWithEmailAndPassword(
        email:    email,
        password: password,
      );

 
      await _db.collection('users').doc(cred.user!.uid).set({
        'name':      name,
        'email':     email,
        'uid':       cred.user!.uid,
        'password': password,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(RegistrationSuccess());
    } on FirebaseAuthException catch (e) {
     
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'This email is already registered.';
        case 'weak-password':
          msg = 'Password is too weak.';
        default:
          msg = 'Authentication error: ${e.message}';
      }
      emit(RegistrationFailure(msg));
    } on FirebaseException catch (e) {
      debugPrint('Firestore error: $e');
      emit(RegistrationFailure('Database error: ${e.message}'));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      emit(RegistrationFailure('Unexpected error: $e'));
    }
  }
}
