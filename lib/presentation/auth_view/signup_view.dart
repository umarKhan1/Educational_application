import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/custom_widget/textfield.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_images_constant.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/application_routes.dart';
import 'package:test/widget/button_widget.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ApplicationImagesConst.applicationBlackLogo, // your logo
                    width: 90.w,
                    height: 90.h,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppString.createAnAccount,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  const SizedBox(height: 80),

                  CustomInputField(
                    label: 'Name',
                    controller: nameController,
                    needlabel: true,
                    hintText: 'Enter Your Name',
                  ),
                  const SizedBox(height: 5),
                  CustomInputField(
                    label: AppString.emailAddressText,
                    controller: emailController,
                    needlabel: true,
                    hintText: AppString.textEmailInputText,
                    suffixIconPath: ApplicationImagesConst.applicationEmailLogo,
                    showPrefixOnFocus: true,
                  ),
                  const SizedBox(height: 5),
                  CustomInputField(
                    label: AppString.passwordText,
                    controller: passwordController,
                    needlabel: true,
                    hintText: AppString.textPasswordInputText,
                    inputType: InputType.password,
                  ),
                  const SizedBox(height: 5),
                  CustomInputField(
                    label: AppString.confirmNewPassword,
                    controller: confirmNewPassword,
                    needlabel: true,
                    hintText: AppString.confirmNewPassword,
                    inputType: InputType.password,
                  ),
                  const SizedBox(height: 30),
                  ApplicationButton(
                    label: AppString.signup,
                    onPressed: () {
                      print('email: ${emailController.text}');
                      NavigationService().pushNamed(
                        ApplicationRoutes.emailVerificationView,
                        arguments: {
                          'email': emailController.text,
                        },
                      );
                    },
                    size: Size(343.w, 50),
                    isWithIcon: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
