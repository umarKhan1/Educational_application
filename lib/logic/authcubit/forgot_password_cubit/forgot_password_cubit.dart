import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:test/logic/authcubit/forgot_password_cubit/forgot_password_state.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  PasswordRecoveryCubit() : super(const PasswordRecoveryState());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String oldpassword = '';

  Future<void> checkEmail(String email) async {
    emit(state.copyWith(phase: RecoveryPhase.checkingEmail));
    try {
      final snap = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      oldpassword = snap.docs.isNotEmpty
          ? snap.docs.first.data()['password'].toString()
          : '';

      if (snap.docs.isEmpty) {
        emit(
          state.copyWith(
            phase: RecoveryPhase.emailNotFound,
            errorMessage: 'No account found for that email.',
          ),
        );
      } else {
        emit(state.copyWith(phase: RecoveryPhase.readyToReset));
      }
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
          phase: RecoveryPhase.failure,
          errorMessage: 'Database error: ${e.message}',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          phase: RecoveryPhase.failure,
          errorMessage: 'Unexpected error: $e',
        ),
      );
    }
  }

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(phase: RecoveryPhase.resettingPassword));
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'no-current-user',
          message: 'No user is currently signed in.',
        );
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      final email = doc.data()?['email'] as String?;
      if (email == null) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'missing-email',
          message: 'Your account has no email on record.',
        );
      }

      final cred = EmailAuthProvider.credential(
        email: email,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(cred);

      await user.updatePassword(newPassword);
      await _firestore.collection('users').doc(user.uid).update({
        'password': newPassword,
      });
      emit(state.copyWith(phase: RecoveryPhase.success));
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'wrong-password':
          msg = 'The old password you entered is incorrect.';
        case 'requires-recent-login':
          msg = 'Session expired: please sign in again and retry.';
        case 'weak-password':
          msg = 'The new password is too weak.';
        case 'no-current-user':
          msg = e.message!;
        default:
          msg = 'Authentication error: ${e.message}';
      }
      emit(state.copyWith(phase: RecoveryPhase.failure, errorMessage: msg));
    } on FirebaseException catch (e) {
      final msg = e.message ?? 'Database error: ${e.code}';
      emit(state.copyWith(phase: RecoveryPhase.failure, errorMessage: msg));
    } catch (e) {
      emit(
        state.copyWith(
          phase: RecoveryPhase.failure,
          errorMessage: 'Unexpected error: $e',
        ),
      );
    }
  }
}
