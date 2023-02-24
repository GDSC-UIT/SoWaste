import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import '../../../global_widget/app_button.dart';

class QuizResultScreen extends StatelessWidget {
  QuizResultScreen({super.key});
  final DictionaryController _dictionaryController = Get.find();
  @override
  Widget build(BuildContext context) {
    bool isPassed = _dictionaryController.currentPoint >=
        0.6 * _dictionaryController.getTotalPoint();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isPassed
                  ? Image.asset('assets/icons/laugh.png')
                  : Image.asset('assets/icons/sad.png'),
              Column(
                children: [
                  Text(
                    isPassed ? 'Congratulations!' : "You failed!",
                    style: CustomTextStyle.h3(AppColors.onBg),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'You ${isPassed ? 'passed' : 'failed'} and got ${_dictionaryController.currentPoint} out of ${_dictionaryController.getTotalPoint()} points',
                    style: CustomTextStyle.bodyBold(AppColors.onBg),
                  ),
                ],
              ),
              AppButton(
                  buttonText: "CONTINUE",
                  onPressedFunction: () {
                    print("Try again");
                  }),
            ]),
      ),
    );
  }
}
