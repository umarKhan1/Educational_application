import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/custom_widget/textfield.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/application_routes.dart';
import 'package:test/widget/button_widget.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fullscreen background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 60.h),
                  Text(
                    AppString.forgotyourpassword,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Theme.of(
                        context,
                      ).textTheme.displayMedium!.fontSize,
                      fontWeight: Theme.of(
                        context,
                      ).textTheme.displayMedium!.fontWeight,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    AppString.enteryourEmail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      fontWeight: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontWeight,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomInputField(
                    label: '',
                    needlabel: false,
                    controller: emailController,
                    hintText: AppString.emailAddressText,
                  ),

                  SizedBox(height: 33.h),

                  ApplicationButton(
                    isWithIcon: true,
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    label: 'Send',
                    onPressed: () {
                      NavigationService().pushNamed(
                        ApplicationRoutes.resetPassword,
                      );
                    },
                    size: Size(335.w, 50),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 33.h,
                  width: 33.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      NavigationService().pop(true);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
