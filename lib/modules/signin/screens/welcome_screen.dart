import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/global_widget/app_button.dart';
import 'package:sowaste/modules/signin/sign_in_controller.dart';

class WelcomeScreen extends StatelessWidget {
  final SignInController _controller = Get.find();
  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Hi there, I’m Earth I’m so glad you\'re using ',
                      style: CustomTextStyle.h3(Colors.black)
                          .copyWith(height: 1.2),
                    ),
                    TextSpan(
                      text: 'SoWaste ',
                      style: CustomTextStyle.h3(AppColors.primary)
                          .copyWith(height: 1.2),
                    ),
                    TextSpan(
                      text: 'to help me stay clean and green',
                      style: CustomTextStyle.h3(Colors.black)
                          .copyWith(height: 1.2),
                    ),
                  ]),
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.welcome,
                    height: 300,
                  ),
                )),
            SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppButton(
                        buttonText: 'HI, EARTH!',
                        onPressedFunction:
                            _controller.navigateToFillInNameScreen),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
