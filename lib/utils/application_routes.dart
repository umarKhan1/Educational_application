import 'package:flutter/material.dart';
import 'package:test/presentation/onboarding_view/onboarding_view.dart';
import 'package:test/presentation/splash_view.dart';

class ApplicationRoutes {

  static const String splash = '/';
  static const String onboardingScreen = '/onboardingScreen';
static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

       case onboardingScreen: 

         return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
        default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
        }
        
        
         }

}
