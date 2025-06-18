import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/custom_widget/textfield.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_images_constant.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/application_routes.dart';
import 'package:test/widget/button_widget.dart';

class ApplicationLoginView extends StatelessWidget {
  ApplicationLoginView({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    ApplicationImagesConst.applicationBlackLogo,
                    height: 90.h,
                    width: 117.w,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 10),
                Center(
                  child: Text(
                    AppString.welcomeBack,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    AppString.loginToContinueText,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),

                SizedBox(height: 50.h),

                CustomInputField(
                  needlabel: true,
                  label: AppString.emailAddressText,
                  controller: emailController,
                  inputType: InputType.email,
                  hintText: AppString.textEmailInputText,
                ),

                CustomInputField(
                  needlabel: true,
                  label: AppString.passwordText,
                  controller: passwordController,
                  inputType: InputType.password,
                  hintText: AppString.textPasswordInputText,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      NavigationService().pushNamed(
                        ApplicationRoutes.forgotpassword,
                      );
                    },
                    child: Text(
                      AppString.forgotpassword,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headlineLarge!.color,
                        fontWeight: Theme.of(
                          context,
                        ).textTheme.displayLarge!.fontWeight,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25.h),
                ApplicationButton(
                  isWithIcon: false,
                  label: AppString.loginText,
                  onPressed: () {},
                  size: Size(double.infinity, 50.h),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: AppString.donthaveAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: AppString.signupNow,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),

                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigationService().pushNamed(
                                ApplicationRoutes.signupView,
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
