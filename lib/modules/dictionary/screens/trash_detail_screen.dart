import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/app_button.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/global_widget/markdown_text.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/screens/question_screen.dart';
import 'package:sowaste/modules/dictionary/screens/quiz_result_screen.dart';

import '../../../data/models/trash.dart';

class TrashDetailScreen extends StatelessWidget {
  TrashDetailScreen({super.key});
  final DictionaryController _dictionaryController = Get.find();
  final Trash _trash = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _dictionaryController.isSaved.value = false;
    _dictionaryController.initCurrentQuiz(_trash.id);
    _dictionaryController.currentTrashName.value = _trash.name;
    _dictionaryController.currentTrashShortDescription.value =
        _trash.shortDescription;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            Obx(() => _dictionaryController.currentQuiz.isNotEmpty
                ? AppButton(
                    buttonText: "START QUIZ",
                    onPressedFunction: () async {
                      // update quiz id
                      _dictionaryController.currentQuizId.value = _trash.id;
                      //get DONE quiz from LOCAL
                      await _dictionaryController.getQuizFromLocal();
                      //If the user has completed the quiz, then navigate to result screen
                      _dictionaryController.isFinishedQuiz.value
                          ? Get.to(() => QuizResultScreen())
                          : Get.to(() => QuestionScreen());
                    })
                : Container()),
        appBar: const ArrowBackAppBar(),
        body: Obx(
          () => _dictionaryController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 80, top: 0),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _trash.name,
                                style:
                                    CustomTextStyle.h3(AppColors.primaryDark),
                                textAlign: TextAlign.start,
                              ),
                              IconButton(
                                onPressed: () =>
                                    {_dictionaryController.saveTrash(_trash)},
                                icon: Obx(() {
                                  for (int i = 0;
                                      i < DataCenter.savedTrashList.length;
                                      ++i) {
                                    if (DataCenter.savedTrashList[i].values
                                        .contains(_trash.id)) {
                                      _dictionaryController
                                          .indexTrashToRemove.value = i;
                                      _dictionaryController.isSaved.value =
                                          true;
                                      break;
                                    }
                                  }
                                  return _dictionaryController.isSaved.value
                                      ? const Icon(
                                          Icons.bookmark,
                                          size: 32,
                                          color: AppColors.secondary,
                                        )
                                      : const Icon(
                                          Icons.bookmark_outline,
                                          size: 32,
                                        );
                                }),
                              )
                            ],
                          ),
                          SizedBox(
                            child: MarkdownText(
                              text: _trash.description!,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ));
  }
}
