import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/logic/splash_cubit.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_images_constant.dart';
import 'package:test/utils/application_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
      Future.microtask(() {
      if (mounted) {
        context.read<SplashCubit>().initializeApp();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, bool>(
        listener: (context, state) {
          if (state) {
            // Navigate to another screen or perform an action
         NavigationService().pushReplacementNamed(
                                  ApplicationRoutes.onboardingScreen);
          }
        },
        child: Stack(
          children: [
            Container(color: Theme.of(context).primaryColor,),
            Center(
              child: Image.asset(
                
                ApplicationImagesConst.applicationLogo,
              
                fit: BoxFit.cover,
                width:309.w,
                height: 242.9.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
