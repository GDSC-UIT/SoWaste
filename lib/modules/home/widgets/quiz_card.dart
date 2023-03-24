import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});
  final LocalQuiz quiz;
  @override
  Widget build(BuildContext context) {
    final percentage = quiz.point! / quiz.totalQuizPoint!;
    final DictionaryController dictionaryController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {dictionaryController.getDetailTrash(quiz.quizId!)},
        child: Container(
          width: 160,
          height: 180,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.5,
                    offset: const Offset(-10, 0),
                    blurRadius: 8,
                    color: AppColors.onBg.withOpacity(0.2),
                    blurStyle: BlurStyle.outer)
              ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              quiz.name!,
              style: CustomTextStyle.bodyBold(AppColors.onBg),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              quiz.shortDescription!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.normal(AppColors.onBg),
            ),
            const Spacer(),
            Text(
              "${(percentage * 100).toStringAsFixed(0)}%",
              style: CustomTextStyle.normal(AppColors.onBg),
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(
                  width: 120,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: percentage * 120,
                  height: 10,
                  decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
