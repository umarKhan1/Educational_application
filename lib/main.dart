import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/logic/authcubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:test/logic/authcubit/login_cubit/login_cubit.dart';
import 'package:test/logic/authcubit/signup_cubit/signup_cubit.dart';

import 'package:test/logic/course_cubit/course_cubit.dart';
import 'package:test/logic/navigation_cubit.dart';
import 'package:test/logic/onboarding_cubit.dart';
import 'package:test/logic/splash_cubit.dart';
import 'package:test/logic/verfication_cubit/verfication_cubit.dart';


import 'package:test/presentation/splash_view.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/app_theme.dart';
import 'package:test/utils/application_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
   await dotenv.load();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CourseCubit()),
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => OnboardingCubit()),
        BlocProvider(
          create: (context) => VerificationCubit(),
        ),
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => RegistrationCubit(),
        ),  
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(create: (context) => PasswordRecoveryCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: ThemeMode.light,
            title: AppString.applicationName,
            home: const SplashScreen(),
            navigatorKey: NavigationService().navigatorKey,
            onGenerateRoute: ApplicationRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
