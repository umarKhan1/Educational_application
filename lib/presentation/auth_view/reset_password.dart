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

class ResetPassword extends StatelessWidget {
  ResetPassword({required this.oldpassword, super.key});
  final String oldpassword;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confrimPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
        listener: (ctx, state) {
           if (state.phase == RecoveryPhase.resettingPassword) {
      showGlassLoader(ctx);
      return;
    }
    if (state.phase == RecoveryPhase.success ||
        state.phase == RecoveryPhase.failure) {
      hideGlassLoader(ctx);
    }

    // Now handle success / failure
    if (state.phase == RecoveryPhase.success) {
      showSuccessModal(ctx);
    } else if (state.phase == RecoveryPhase.failure) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    }
    
          },
            builder: (context, state) {
              return Form(
                key:formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              AppString.resetPassword,
                              style: TextStyle(
                                fontSize: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.fontSize,
                                fontWeight: Theme.of(
                                  context,
                                ).textTheme.displayLarge!.fontWeight,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 24.w),
                      ],
                    ),
                    SizedBox(height: 32.h),
                
                    CustomInputField(
                      needlabel: true,
                      label: AppString.newpassword,
                      controller: newPasswordController,
                      hintText: '*************',
                      inputType: InputType.password,
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      needlabel: true,
                      label: AppString.confirmNewPassword,
                      controller: confrimPasswordController,
                      
                      matchController: newPasswordController,
                      hintText: '*************',
                      inputType: InputType.password,
                    ),
                
                    SizedBox(height: 60.h),
                
                    ApplicationButton(
                      label: AppString.submitText,
                      onPressed: () {
                       
                          if (!formKey.currentState!.validate()) return;
                      context.read<PasswordRecoveryCubit>().resetPassword(
                                oldPassword:  oldpassword,
                                newPassword: newPasswordController.text,
                                confirmPassword: confrimPasswordController.text,
                              );
                    
                      },
                      size: const Size(0, 50),
                      isWithIcon: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void showSuccessModal(BuildContext context) {
    final mq = MediaQuery.of(context);
    final totalH =
        mq.size.height -
        mq.padding.top -
        mq.padding.bottom -
        mq.viewInsets.bottom;

    // pick a “reasonable” fraction
    final sheetFraction = totalH < 500
        ? 0.4
        : totalH < 700
        ? 0.35
        : 0.34;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      isDismissible: false, // prevent tap-outside dismissal
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SizedBox(
        height: totalH * sheetFraction,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.grey.shade500,
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                Text(
                  AppString.passwordRestSucessfully,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Subtitle
                Text(
                  AppString.youCanNowlogin,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                    color: Colors.black54,
                  ),
                ),
                const Spacer(),
                // Proceed button
                ApplicationButton(
                  label: AppString.proceed,
                  onPressed: () => NavigationService().pushReplacementNamed(
                    ApplicationRoutes.applicationLoginView,
                  ),
                  size: Size(343.w, 50),
                  isWithIcon: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
