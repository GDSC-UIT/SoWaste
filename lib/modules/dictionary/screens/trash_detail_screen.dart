import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
          for (Trash t in dictionaryController.savedTrashList) {
            if (t.id.compareTo(trash.id) == 0) {
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
                      Get.to(() => QuestionScreen());
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
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
                              style: CustomTextStyle.h2(AppColors.primary)
                                  .copyWith(height: 1.2),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          save(trash)
                        ],
                      ),
                      SizedBox(
                        child: MarkdownText(text: trash.shortDescription),
                        // child: Column(
                        //   children: [
                        //     Text("Types",
                        //         style: CustomTextStyle.title(Colors.black)),
                        //     Column(
                        //         children: trash.types!
                        //             .map(
                        //               (e) => ListTile(
                        //                 leading: const Icon(Icons.circle),
                        //                 title: Text(e),
                        //               ),
                        //             )
                        //             .toList()),
                        //     Text("Recyclable items",
                        //         style: CustomTextStyle.title(Colors.black)),
                        //     Column(
                        //       children: trash.reItems!
                        //           .map(
                        //             (e) => ListTile(
                        //               leading: const Icon(Icons.circle),
                        //               title: Text(e),
                        //             ),
                        //           )
                        //           .toList(),
                        //     ),
                        //     Text("Non recyclable items",
                        //         style: CustomTextStyle.title(Colors.black)),
                        //     Column(
                        //       children: trash.nonReItems!
                        //           .map(
                        //             (e) => ListTile(
                        //               leading: const Icon(Icons.circle),
                        //               title: Text(e),
                        //             ),
                        //           )
                        //           .toList(),
                        //     ),

                        // ],
                      ),
                      SizedBox(
                        height: dictionaryController.currentQuiz.isNotEmpty
                            ? 200
                            : 8,
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        }));
  }
}
