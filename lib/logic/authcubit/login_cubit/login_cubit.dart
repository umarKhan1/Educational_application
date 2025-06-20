import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/logic/authcubit/login_cubit/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _auth = FirebaseAuth.instance;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'invalid-email':
          msg = 'Please enter a valid email address.';
        case 'user-disabled':
          msg = 'This user has been disabled.';
        case 'user-not-found':
          msg = 'No user found for that email.';
        case 'wrong-password':
          msg = 'Incorrect password.';
        case 'too-many-requests':
          msg = 'Too many attempts. Try again later.';
        case 'operation-not-allowed':
          msg = 'Email/password sign-in is not enabled.';
        default:
          msg = 'Authentication error: ${e.message}';
      }
      emit(LoginFailure(msg));
    } catch (e) {
      emit(LoginFailure('Unexpected error: $e'));
    }
  }
}
