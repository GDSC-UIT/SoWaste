import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
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
  void gotoHomeScreen() {
    Get.toNamed(AppRoutes.homePage);
  }

  Widget getStartBtn() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: gotoHomeScreen,
        child:
            Text("GET STARTED", style: CustomTextStyle.button(Colors.white)));
  }

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
                  image: customImage('assets/images/dustbin.png'),
                  title: "Raise awareness",
                  body:
                      "Garbage pollution threatens the environment and public health.",
                  decoration: pageDecoration()),
              PageViewModel(
                  image: customImage('assets/images/recycle.png'),
                  title: "Reduce waste",
                  body:
                      "Reducing trash by recycling is crucial for preserving our planet's health.",
                  decoration: pageDecoration()),
              PageViewModel(
                  image: customImage('assets/images/sort.png'),
                  title: "Sorting trash",
                  body:
                      "Effective trash management can help address the garbage pollution.",
                  decoration: pageDecoration()),
            ],
            onChange: (index) => {
              _controller.pageIndex.value = index,
            },
            dotsDecorator: getDotDecoration(),
            // done: const Text("Done"),
            showNextButton: false,
            showDoneButton: false,
            showSkipButton: false,
            skip: const Text(
              'Skip',
            ),

            // onDone: gotoHomeScreen,
            next: const Icon(Icons.arrow_forward),
          ),
        ),
        SizedBox(
          height: 56,
          width: 350,
          child: Obx(
            () => (_controller.pageIndex.value == 2)
                ? getStartBtn()
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
