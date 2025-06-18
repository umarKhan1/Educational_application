import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/verfication_cubit/verfication_state.dart';

class VerificationCubit extends Cubit<VerificationState> {

  VerificationCubit()
      : super(VerificationState(
          code: List.filled(4, ''),
          secondsRemaining: 60,
          canResend: false,
          isSubmitting: false,
        )) {
    _startTimer();
  }
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    emit(state.copyWith(secondsRemaining: 60, canResend: false));
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final sec = state.secondsRemaining - 1;
      if (sec <= 0) {
        t.cancel();
        emit(state.copyWith(secondsRemaining: 0, canResend: true));
      } else {
        emit(state.copyWith(secondsRemaining: sec));
      }
    });
  }

  void updateDigit(int index, String digit) {
    final newCode = List<String>.from(state.code)..[index] = digit;
    emit(state.copyWith(code: newCode));
  }

  void resendCode() {
    if (!state.canResend) return;
 
    _startTimer();
  }

  Future<void> submit() async {
    if (state.code.any((c) => c.isEmpty)) {
      emit(state.copyWith(errorMessage: 'Enter 4-digit code'));
      return;
    }
    // ignore: avoid_redundant_argument_values
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      final _ = state.code.join();
   
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isSubmitting: false));
     
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
