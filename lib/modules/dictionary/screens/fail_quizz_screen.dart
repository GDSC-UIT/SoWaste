import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/global_widget/app_button.dart';

class FailQuizScreen extends StatelessWidget {
  const FailQuizScreen({super.key});
  final count = 5;
  final allQuestions = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icons/laugh.png'),
              Column(
                children: [
                  Text(
                    'You failed!',
                    style: CustomTextStyle.h3(AppColors.onBg),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'You passed ${count} of ${allQuestions} questions',
                    style: CustomTextStyle.bodyBold(AppColors.onBg),
                  ),
                ],
              ),
              Column(
                children: [
                  AppButton(
                      buttonText: "TRY AGAIN",
                      onPressedFunction: () {
                        print("Try again");
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  AppButton(
                    buttonText: "QUIT",
                    onPressedFunction: () {
                      print("Quit");
                    },
                    color: AppColors.background,
                    textColor: AppColors.info,
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
