import 'package:test/utils/app_images_constant.dart';
import 'package:test/utils/app_string.dart';

class OnboardingContent {

  OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image;
  final String title;
  final String subtitle;

  static final  onboardingPages = [
  OnboardingContent(
    image: ApplicationImagesConst.applicationOnBoardingOne,
    title: AppString.onboardingFirstTitle,
    subtitle: AppString.onboardingFirstSubtitle
  ),
  OnboardingContent(
    image: ApplicationImagesConst.applicationOnBoardingTwo,
   title: AppString.onboardingSecondTitle,
    subtitle: AppString.onboardingTwoSubtitle,
  ),
  OnboardingContent(
     image: ApplicationImagesConst.applicationOnBoardingThree,
   title: AppString.onboardingThirdTitle,
    subtitle: AppString.onboardingThirdSubtitle,
  ),
];
}
