import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/custom_widget/custom_loader.dart';
import 'package:test/custom_widget/textfield.dart';
import 'package:test/logic/authcubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:test/logic/authcubit/forgot_password_cubit/forgot_password_state.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/application_routes.dart';
import 'package:test/widget/button_widget.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? oldPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
            listener: (context, state) {
              if (state.phase == RecoveryPhase.checkingEmail) {
               showGlassLoader(context);
              } else {
                hideGlassLoader(context);
              }
              if (state.phase == RecoveryPhase.emailNotFound ||
                  state.phase == RecoveryPhase.failure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
              if (state.phase == RecoveryPhase.readyToReset) {
oldPassword = context.read<PasswordRecoveryCubit>().oldpassword;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email found! Proceed to reset password.')),
                );
                // Navigate to reset password screen with old password

                NavigationService().pushReplacementNamed(ApplicationRoutes.resetPassword, arguments: oldPassword);  
              }
            },
            builder: (context, state) {
               
              return Stack(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
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
                            color: Theme.of(
                              context,
                            ).textTheme.displayLarge!.color,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          AppString.enteryourEmail,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.fontSize,
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
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: 'Send',
                          onPressed: () {

                          if (!formKey.currentState!.validate()) return;

                            context.read<PasswordRecoveryCubit>().checkEmail(
                                  emailController.text,
                                );

                          },
                          size: Size(335.w, 50),
                        ),
                      ],
                    ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
