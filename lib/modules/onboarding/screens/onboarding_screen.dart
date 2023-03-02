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
        width: 190,
      ),
    );
  }

  PageDecoration pageDecoration() => PageDecoration(
      imageFlex: 5,
      bodyFlex: 4,
      titleTextStyle: CustomTextStyle.h3(AppColors.primary),
      bodyTextStyle: CustomTextStyle.medium(AppColors.primary),
      titlePadding: const EdgeInsets.only(bottom: 16),
      pageColor: AppColors.background);

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
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                  image: customImage(AppImages.dustbin),
                  title: "Raise awareness",
                  body:
                      "Garbage pollution threatens the environment and public health.",
                  decoration: pageDecoration()),
              PageViewModel(
                  image: customImage(AppImages.recycle),
                  title: "Reduce waste",
                  body:
                      "Reducing trash by recycling is crucial for preserving our planet's health.",
                  decoration: pageDecoration()),
              PageViewModel(
                  image: customImage(AppImages.sort),
                  title: "Sorting trash",
                  body:
                      "Effective trash management can help address the garbage pollution.",
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
                        {Get.offAndToNamed(AppRoutes.base)})
                : Container(),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    ));
  }
}
