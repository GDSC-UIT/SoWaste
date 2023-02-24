import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/global_widget/app_button.dart';
import 'package:sowaste/global_widget/markdown_text.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/screens/question_screen.dart';

import '../../../data/models/trash.dart';

class TrashDetailScreen extends StatelessWidget {
  TrashDetailScreen({super.key});
  final DictionaryController _dictionaryController = Get.find();
  final Trash _trash = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.height * 0.2,
                  width: double.infinity,
                  child: Image.network(
                    _trash.displayImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  _trash.name,
                  style: CustomTextStyle.h1(AppColors.primaryDark),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  child: MarkdownText(
                    text: _trash.description,
                  ),
                ),
              ],
            ),
            AppButton(
                buttonText: "START QUIZ",
                onPressedFunction: () async {
                  await _dictionaryController.getCurrenQuiz(_trash.id);
                  print(
                      "Quiz length: ${_dictionaryController.currentQuiz.length}");
                  print(_dictionaryController.currentQuiz);

                  Get.to(() => QuestionScreen());
                })
          ],
        ),
      ),
    );
  }
}
