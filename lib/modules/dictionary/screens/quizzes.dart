import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import '../../../global_widget/app_card_button.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DictionaryController dictionaryController = Get.find();
    return Scaffold(
        appBar: const ArrowBackAppBar(
          title: "Quizzes",
        ),
        body: Obx(() => ListView.builder(
              itemBuilder: (context, index) {
                if (DataCenter.allQuizzes[index].questions.isNotEmpty) {
                  final localQuizIndex = DataCenter.localQuizList.indexWhere(
                      (q) => q.quizId == DataCenter.allQuizzes[index].quizId);
                  double percentage = (localQuizIndex >= 0
                      ? DataCenter.localQuizList[localQuizIndex].point! /
                          DataCenter
                              .localQuizList[localQuizIndex].totalQuizPoint!
                      : 0);
                  return AppCardButton(
                    onTapFunction: () => {
                      dictionaryController
                          .getDetailTrash(DataCenter.allQuizzes[index].quizId)
                    },
                    title: DataCenter.allQuizzes[index].quizName,
                    trailing: CircularPercentIndicator(
                      animationDuration: 300,
                      radius: 24,
                      lineWidth: 4,
                      progressColor: percentage == 1.0
                          ? AppColors.primary
                          : AppColors.secondary,
                      animation: true,
                      percent: percentage,
                      center: Text(
                        '${(percentage * 100).toStringAsFixed(0)}%',
                        style: percentage == 1.0
                            ? CustomTextStyle.link(AppColors.primary)
                            : CustomTextStyle.link(AppColors.secondary),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: DataCenter.allQuizzes.length,
            )));
  }
}
