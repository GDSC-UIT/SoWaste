import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import '../../../global_widget/app_button.dart';

class QuizResultScreen extends StatelessWidget {
  QuizResultScreen({super.key});
  final DictionaryController _dictionaryController = Get.find();
  @override
  Widget build(BuildContext context) {
    _dictionaryController.isFinishedQuiz.value = true;
    bool isPassed = _dictionaryController.totalPoint >=
        0.6 * _dictionaryController.getTotalPoint();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isPassed
                  ? Image.asset(AppImages.congra)
                  : Image.asset(AppImages.fail),
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
                    'You ${isPassed ? 'passed' : 'failed'} and got ${_dictionaryController.totalPoint} out of ${_dictionaryController.getTotalPoint()} points',
                    style: CustomTextStyle.bodyBold(AppColors.onBg),
                  ),
                ],
              ),
              AppButton(
                  buttonText: "TRY AGAIN",
                  onPressedFunction: () async {
                    _dictionaryController.initCurrentQuiz();
                    Get.toNamed(AppRoutes.questionsPage);
                  }),
              AppButton(
                buttonText: "QUIT",
                onPressedFunction: () {
                  _dictionaryController.initCurrentQuiz();
                  Get.back();
                },
                color: AppColors.background,
                textColor: Colors.black,
              )
            ]),
      ),
    );
  }
}
