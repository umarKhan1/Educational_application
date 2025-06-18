
class VerificationState {    

  VerificationState({
    required this.code,
    required this.secondsRemaining,
    required this.canResend,
    required this.isSubmitting,
    this.errorMessage,
  });
  final List<String> code;       
  final int secondsRemaining;    
  final bool canResend;           
  final bool isSubmitting;       
 
  final String? errorMessage;

  VerificationState copyWith({
    List<String>? code,
    int? secondsRemaining,
    bool? canResend,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return VerificationState(
      code: code ?? this.code,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }
}
