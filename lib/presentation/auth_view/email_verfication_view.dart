import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/logic/verfication_cubit/verfication_cubit.dart';
import 'package:test/logic/verfication_cubit/verfication_state.dart';
import 'package:test/utils/app_string.dart';

class EmailVerficationView extends StatelessWidget {
  EmailVerficationView({required this.email, super.key});
  Map<String, dynamic> email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: BlocConsumer<VerificationCubit, VerificationState>(
            listener: (ctx, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(
                  ctx,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            },
            builder: (ctx, state) {
              final purple = Theme.of(context).primaryColor;
              // format mm:ss
              final min = (state.secondsRemaining ~/ 60).toString().padLeft(
                2,
                '0',
              );
              final sec = (state.secondsRemaining % 60).toString().padLeft(
                2,
                '0',
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        AppString.verifyyouemail,
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),

                  SizedBox(height: 150.h),
                  // ← Instruction Text
                  Text.rich(
                    TextSpan(
                      text: AppString.weSentYouCode,
                      style: TextStyle(
                        fontSize: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.fontSize,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: '(${email['email']})',
                          style: TextStyle(
                            fontSize: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppString.enterCode,
                    style: TextStyle(
                      fontSize: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.fontSize,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: 62.w,
                          height: 65.h,
                          child: TextField(
                            expands: true,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(fontSize: 23),
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 0.6,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              ctx.read<VerificationCubit>().updateDigit(i, val);
                              if (val.isNotEmpty && i < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 70.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppString.didnotgetyourCode),
                      GestureDetector(
                        onTap: ctx.read<VerificationCubit>().resendCode,
                        child: Text(
                          AppString.resendCode,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: state.canResend ? purple : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: AppString.exipreIn,
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: '$min:$sec',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ← Submit button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () => ctx.read<VerificationCubit>().submit(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state.isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
