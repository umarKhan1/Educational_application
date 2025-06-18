import 'package:flutter/material.dart';
import 'package:test/presentation/auth_view/email_verfication_view.dart';
import 'package:test/presentation/auth_view/forgot_password.dart';
import 'package:test/presentation/auth_view/login_view.dart';
import 'package:test/presentation/auth_view/reset_password.dart';
import 'package:test/presentation/auth_view/signup_view.dart';
import 'package:test/presentation/onboarding_view/onboarding_view.dart';
import 'package:test/presentation/splash_view.dart';

class ApplicationRoutes {
  static const String splash = '/';
  static const String onboardingScreen = '/onboardingScreen';
  static const String applicationLoginView = '/loginView';
  static const String forgotpassword = '/forgotpassword';
  static const String resetPassword = '/resetPassword';
  static const String signupView = '/signupView';
  static const String emailVerificationView = '/emailVerificationView';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case applicationLoginView:
        return MaterialPageRoute(builder: (_) => ApplicationLoginView());
      case forgotpassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case signupView:
        return MaterialPageRoute(builder: (_) => SignupView());

      case emailVerificationView:
        return MaterialPageRoute(
          builder: (_) => EmailVerficationView(
            email: settings.arguments! as Map<String, dynamic>,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
