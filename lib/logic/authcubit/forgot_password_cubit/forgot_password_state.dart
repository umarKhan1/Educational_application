import 'package:equatable/equatable.dart';

enum RecoveryPhase {
  initial,
  checkingEmail,
  emailNotFound,
  readyToReset,
  resettingPassword,
  success,
  failure,
}

class PasswordRecoveryState extends Equatable {

  const PasswordRecoveryState({
    this.phase = RecoveryPhase.initial,
    this.errorMessage,
  });
  final RecoveryPhase phase;
  final String? errorMessage;

  PasswordRecoveryState copyWith({
    RecoveryPhase? phase,
    String? errorMessage,
  }) {
    return PasswordRecoveryState(
      phase: phase ?? this.phase,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [phase, errorMessage];

}
