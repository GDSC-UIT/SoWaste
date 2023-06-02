import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/global_widget/app_button.dart';
import 'package:sowaste/modules/onboarding/onboarding_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController _controller = Get.find();

  OnboardingScreen({super.key});
  Widget customImage(String path) {
    return Center(
      child: Image.asset(
        path,
        height: 250,
      ),
    );
  }

  PageDecoration pageDecoration() => PageDecoration(
          contentMargin: const EdgeInsets.all(0),
          bodyPadding: const EdgeInsets.symmetric(horizontal: 0),
          imageFlex: 5,
          bodyFlex: 4,
          titleTextStyle:
              CustomTextStyle.h3(AppColors.primary).copyWith(height: 1),
          bodyTextStyle: CustomTextStyle.medium(AppColors.primary),
          titlePadding: const EdgeInsets.only(bottom: 16),
          pageColor: AppColors.background)
      .copyWith(
          titlePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          descriptionPadding: const EdgeInsets.symmetric(horizontal: 16));

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: AppColors.primaryLight,
      size: const Size(10, 10),
      activeColor: AppColors.primaryDark,
      activeSize: const Size(30, 10),
      activeShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: IntroductionScreen(
              pages: [
                PageViewModel(
                    image: customImage(AppImages.onboarding1),
                    title: "Sort waste with ease",
                    body:
                        "Our AI camera feature helps you identify the waste type and provides recycling guidance.",
                    decoration: pageDecoration()),
                PageViewModel(
                    image: customImage(AppImages.onboarding2),
                    title: "Learn and recycle",
                    body:
                        "Reducing waste by recycling is crucial for preserving our planet's health.",
                    decoration: pageDecoration()),
                PageViewModel(
                    image: customImage(AppImages.onboarding3),
                    title: "Contribute to earn rewards",
                    body:
                        "Find nearby recycling points and scrap shops to sell or donate your recyclables.",
                    decoration: pageDecoration()),
              ],
              onChange: (index) => {
                _controller.pageIndex.value = index,
              },
              dotsDecorator: getDotDecoration(),
              showNextButton: false,
              showDoneButton: false,
              showSkipButton: false,
              skip: const Text(
                'Skip',
              ),
              next: const Icon(Icons.arrow_forward),
            ),
          ),
          SizedBox(
            height: 56,
            width: 350,
            child: Obx(
              () => (_controller.pageIndex.value == 2)
                  ? AppButton(
                      buttonText: "GET STARTED",
                      onPressedFunction: () =>
                          {Get.offAndToNamed(AppRoutes.signInPage)})
                  : Container(),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }
}
