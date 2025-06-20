import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:test/presentation/home_view/widget/course_widget.dart';
import 'package:test/utils/app_images_constant.dart';
import 'package:test/utils/app_string.dart';


class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ApplicationImagesConst.applicationDrawerImage,
                    width: 25.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    ApplicationImagesConst.applicationPersonalImage,
                    width: 25.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text(
                AppString.helloText,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppString.whatYouWantToLearn,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: Colors.grey[600],
                ),
              ),

              SizedBox(height: 40.h),

              // ── Search bar ───────────────────────────────────────
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search..',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15.sp,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 12),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                      size: 25.h,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 10),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 44.h),

              SizedBox(
                height: 120.h,

                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        ApplicationImagesConst.applicationBannerImage,
                        width: MediaQuery.of(context).size.width,
                        height: 120.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppString.newCourses,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            AppString.userExperienceClass,
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              AppString.viewNow,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Section header ───────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.course,
                    style: TextStyle(
                      fontSize: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppString.viewAll,
                      style: TextStyle(
                        fontSize: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.fontSize,
                        color: Colors.purple.shade300,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

        const   CourseSelectWidget(),
            // ── Bottom nav ───────────────────────────────────────
            ],
          ),
        ),
      ),
    );
  }
}
