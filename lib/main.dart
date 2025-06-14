import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/logic/book_cubit/book_cubit.dart';
import 'package:test/logic/splash_cubit.dart';
import 'package:test/model/book_model.dart';

import 'package:test/presentation/splash_view.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/app_theme.dart';
import 'package:test/utils/application_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookSearchCubit(BookModel.books)),
        BlocProvider(create: (context) => SplashCubit()),
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
