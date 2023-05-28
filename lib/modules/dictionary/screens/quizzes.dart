import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/home/home_controller.dart';

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
          title: "Quiz result",
        ),
        body: Obx(() => ListView.builder(
              itemBuilder: (context, index) {
                if (dictionaryController.doneQuizList.isNotEmpty) {
                  double percentage = dictionaryController
                          .doneQuizList[index].userPoint /
                      dictionaryController.doneQuizList[index].totalQuizPoint;

                  return AppCardButton(
                    onTapFunction: () => {
                      dictionaryController.getDetailTrash(
                          dictionaryController.doneQuizList[index].trashId)
                    },
                    title: dictionaryController.doneQuizList[index].name,
                    trailing: CircularPercentIndicator(
                      animationDuration: 300,
                      radius: 24,
                      lineWidth: 4,
                      progressColor: AppColors.primary,
                      animation: true,
                      percent: percentage,
                      center: Text('${(percentage * 100).toStringAsFixed(0)}%',
                          style: CustomTextStyle.link(Colors.black54)),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: dictionaryController.doneQuizList.length,
            )));
  }
}
