import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/data/models/option.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

class OptionButton extends StatelessWidget {
  OptionButton(
      {super.key,
      required this.option,
      required this.isAble,
      required this.optionIndex,
      required this.point});
  final Option option;
  final bool isAble;
  final int optionIndex;
  final int point;
  final DictionaryController _dictionaryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: IgnorePointer(
          ignoring: !isAble,
          child: InkWell(
            onTap: () async {
              _dictionaryController.userAnswer.value = optionIndex;
              if (option.isCorrect) {
                _dictionaryController.addPoint(point);
              }
              _dictionaryController.doneQuestions.add(LocalQuestion(
                  questionId: option.questionId,
                  optionId: option.id,
                  isCorrect: option.isCorrect));

              await _dictionaryController.postQuizToLocal();
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Obx(() => Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border:
                          _dictionaryController.userAnswer.value != optionIndex
                              ? Border.all(color: AppColors.info, width: 1)
                              : null,
                      color: option.isCorrect &&
                              _dictionaryController.userAnswer.value != 0
                          ? AppColors.primaryDark
                          : (!option.isCorrect &&
                                  _dictionaryController.userAnswer.value ==
                                      optionIndex
                              ? AppColors.error
                              : AppColors.background)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(child: Text(option.description)),
                  ),
                )),
          ),
        ));
  }
}
