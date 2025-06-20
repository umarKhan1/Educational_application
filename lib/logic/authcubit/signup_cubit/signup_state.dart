import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
  @override
  List<Object?> get props => [];
}

/// Initial state — show your “Enter email” form
class RegistrationInitial extends RegistrationState {}

/// Loading — used for sending email, resending, and final registration
class RegistrationLoading extends RegistrationState {}

/// Code has been sent (or resent) — show your “Enter 4-digit code” form
class RegistrationCodeSent extends RegistrationState {}

/// Final registration succeeded (Auth + Firestore)
class RegistrationSuccess extends RegistrationState {}

/// Any error — shows SnackBar or dialog with [message]
class RegistrationFailure extends RegistrationState {
  const RegistrationFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
