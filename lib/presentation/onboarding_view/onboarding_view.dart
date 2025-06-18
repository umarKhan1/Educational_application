import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/logic/onboarding_cubit.dart';
import 'package:test/model/on_boarding_model.dart';
import 'package:test/services/navigation_servies.dart';
import 'package:test/utils/app_string.dart';
import 'package:test/utils/application_routes.dart';
import 'package:test/widget/button_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, int>(
          builder: (context, index) {
            return Column(
              children: [
                // Skip Button
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    child: TextButton(
                      onPressed: () {
                        context.read<OnboardingCubit>().skipToEnd();
                        controller.jumpToPage(2);
                      },
                      child: Text(
                        AppString.skipText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (i) =>
                        context.read<OnboardingCubit>().goToPage(i),
                    itemCount: OnboardingContent.onboardingPages.length,
                    itemBuilder: (_, i) {
                      final content = OnboardingContent.onboardingPages[i];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 🖼️ Image
                          Image.asset(content.image, height: 250),

                          const SizedBox(height: 20),
                                BlocBuilder<OnboardingCubit, int>(
                            builder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  OnboardingContent.onboardingPages.length,
                                  (j) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: j == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 30),

                          // 📝 Title
                          Text(
                            content.title,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.color,
                              fontWeight: Theme.of(
                                context,
                              ).textTheme.displayLarge!.fontWeight,
                              fontSize: Theme.of(
                                context,
                              ).textTheme.headlineSmall!.fontSize,
                            ),
                          ),

                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              content.subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: Theme.of(
                                  context,
                                ).textTheme.displayMedium!.fontWeight,
                                fontSize: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.fontSize,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Next Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: index == OnboardingContent.onboardingPages.length - 1
                        ?
                          // 🔹 Only "Get Started" full-width button
                          ApplicationButton(
                            isWithIcon: false,
                            size: Size(double.infinity, 50.h),
                            label: AppString.getStarted,
                            onPressed: () {
                            
                              NavigationService().pushNamed(
                                ApplicationRoutes.applicationLoginView,
                              );
                            },
                          )
                        :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (index > 0)
                                ApplicationButton(
                                  isWithIcon: false,
                                  size: Size(150.w, 50.h),
                                  label: AppString.backText,
                                  onPressed: () {
                                    controller.previousPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                    context
                                        .read<OnboardingCubit>()
                                        .previousPage();
                                  },
                                )
                              else
                                const SizedBox(
                                  width: 150,
                                ), // placeholder for alignment
                              // Next Button
                              ApplicationButton(
                                isWithIcon: false,
                                size: Size(150.w, 50.h),
                                label: AppString.nextText,
                                onPressed: () {
                                  controller.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                  context.read<OnboardingCubit>().nextPage();
                                },
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
