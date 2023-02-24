import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/global_widget/app_button.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/screens/quiz_result_screen.dart';
import 'package:sowaste/modules/dictionary/widgets/option_button.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({
    super.key,
  });
  final DictionaryController _dictionaryController = Get.find();
  @override
  Widget build(BuildContext context) {
    print("OptionLength: $_dictionaryController");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Quiz: Plastic Bottle",
            style: CustomTextStyle.sub(AppColors.primary),
          ),
        ),
        body: Obx(() {
          final index = _dictionaryController.currentQuestionIndex.value;
          final Question question = _dictionaryController.currentQuiz[index];
          return ListView(
            padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
            children: [
              Text(
                "Point: ${_dictionaryController.currentPoint} ",
                style: CustomTextStyle.title(AppColors.secondary),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Question ${index + 1}",
                style: CustomTextStyle.sub(AppColors.onBg),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                question.title,
                style: CustomTextStyle.large(AppColors.onBg),
              ),
              const SizedBox(
                height: 24,
              ),
              (Obx(() {
                return Column(
                  children: question.options!
                      .map((e) => OptionButton(
                            point: question.point,
                            optionIndex: question.options!.indexOf(e) + 1,
                            option: e,
                            isAble: _dictionaryController.userAnswer.value == 0
                                ? true
                                : false,
                          ))
                      .toList(),
                );
              })),
              AppButton(
                  buttonText:
                      index + 1 < _dictionaryController.currentQuiz.length
                          ? "CONTINUE"
                          : "FINISH",
                  onPressedFunction: () {
                    _dictionaryController.userAnswer.value = 0;
                    if (index + 1 < _dictionaryController.currentQuiz.length) {
                      _dictionaryController.currentQuestionIndex.value++;
                    } else {
                      Get.off(() => QuizResultScreen());
                    }
                  })
            ],
          );
        }));
  }
}
