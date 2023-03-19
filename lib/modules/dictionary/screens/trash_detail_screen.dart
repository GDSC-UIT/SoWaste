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
  const TrashDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DictionaryController dictionaryController = Get.find();
    dictionaryController.isSaved.value = false;

    IconButton save(Trash trash) {
      return IconButton(
        onPressed: () => {dictionaryController.saveTrash(trash)},
        icon: Obx(() {
          for (int i = 0; i < DataCenter.savedTrashList.length; ++i) {
            if (DataCenter.savedTrashList[i].values.contains(trash.id)) {
              dictionaryController.indexTrashToRemove.value = i;
              dictionaryController.isSaved.value = true;
              break;
            }
          }
          return dictionaryController.isSaved.value
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
      );
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: const ArrowBackAppBar(),
        floatingActionButton:
            Obx(() => dictionaryController.currentQuiz.isNotEmpty
                ? AppButton(
                    buttonText: "START QUIZ",
                    onPressedFunction: () async {
                      //get DONE quiz from LOCAL
                      await dictionaryController.getQuizFromLocal();
                      //If the user has completed the quiz, then navigate to result screen
                      dictionaryController.isFinishedQuiz.value
                          ? Get.to(() => QuizResultScreen())
                          : Get.to(() => QuestionScreen());
                    })
                : Container()),
        body: Obx(() {
          if (dictionaryController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else {
            final Trash trash = dictionaryController.currentTrash.value;
            return Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom:
                      (dictionaryController.currentQuiz.isNotEmpty ? 78 : 8),
                  top: 0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              trash.name,
                              style: CustomTextStyle.h2(AppColors.primaryDark)
                                  .copyWith(height: 1.2),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          save(trash)
                        ],
                      ),
                      SizedBox(
                        child: MarkdownText(
                          text: trash.description!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }));
  }
}
