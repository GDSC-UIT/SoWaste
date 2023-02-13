import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import '../../../global_widget/app_card_button.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Recent types of trash",
            style: CustomTextStyle.sub(AppColors.primary),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            double percent =
                double.parse(Random().nextDouble().toStringAsFixed(1));
            return AppCardButton(
              onTapFunction: () {
                print("Clicked on Card!");
              },
              title: "Quiz of trash type: Plastic bottle",
              trailing: CircularPercentIndicator(
                animationDuration: 300,
                radius: 24,
                lineWidth: 4,
                progressColor:
                    percent == 1.0 ? AppColors.primary : AppColors.secondary,
                animation: true,
                percent: percent,
                center: Text(
                  '${(double.parse(percent.toStringAsFixed(2)) * 100).toString()}%',
                  style: percent == 1.0
                      ? CustomTextStyle.link(AppColors.primary)
                      : CustomTextStyle.link(AppColors.secondary),
                ),
              ),
            );
          },
          itemCount: 10,
        ));
  }
}
