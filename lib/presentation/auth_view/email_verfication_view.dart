import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/logic/authcubit/signup_cubit/signup_cubit.dart';
import 'package:test/logic/authcubit/signup_cubit/signup_state.dart';
import 'package:test/logic/verfication_cubit/verfication_cubit.dart';
import 'package:test/logic/verfication_cubit/verfication_state.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/application_routes.dart';

class EmailVerficationView extends StatefulWidget {
  EmailVerficationView({required this.email, super.key});
  Map<String, dynamic> email;

  @override
  State<EmailVerficationView> createState() => _EmailVerficationViewState();
}

class _EmailVerficationViewState extends State<EmailVerficationView> {
  @override
  void initState() {
    super.initState();
    context.read<RegistrationCubit>().sendCode(
      email: widget.email['email'].toString(),
      name: widget.email['username'].toString(),
      password: widget.email['password'].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: MultiBlocListener(
            listeners: [
              BlocListener<RegistrationCubit, RegistrationState>(
                listener: (ctx, regState) {
                  if (regState is RegistrationLoading) {
                  } else if (regState is RegistrationFailure) {
                    ScaffoldMessenger.of(
                      ctx,
                    ).showSnackBar(SnackBar(content: Text(regState.message)));
                  } else if (regState is RegistrationSuccess) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(content: Text('Login successful!')),
                    );
                    Navigator.of(context).pushReplacementNamed(
                      ApplicationRoutes.bottomNavigationView,
                    );
                  }
                },
              ),
            ],
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
                            text: '(${widget.email['email']})',
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
                                ctx.read<VerificationCubit>().updateDigit(
                                  i,
                                  val,
                                );
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
                          onTap: () {
                            ctx.read<VerificationCubit>().resendCode();
                            context.read<RegistrationCubit>().sendCode(
                              email: widget.email['email'].toString(),
                              name: widget.email['username'].toString(),
                              password: widget.email['password'].toString(),
                            );
                          },
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

                
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                final code = state.code.join();
                                if (code.length < 4) {
                                  ctx.read<VerificationCubit>().emit(
                                    state.copyWith(
                                      errorMessage: 'Enter 4-digit code',
                                    ),
                                  );
                                } else {
                                  // show spinner in the verification cubit
                                  ctx.read<VerificationCubit>().emit(
                                    state.copyWith(
                                      isSubmitting: true,
                                      errorMessage: null,
                                    ),
                                  );
                                  // verify and register
                                  context.read<RegistrationCubit>().verifyCode(
                                    code,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state.isSubmitting
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
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
      ),
    );
  }
}
