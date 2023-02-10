import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class QuizCard extends StatelessWidget {
  QuizCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.percentage,
  });
  double percentage;
  String title;
  String subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
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
              title,
              style: CustomTextStyle.bodyBold(AppColors.onBg),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              subTitle,
              style: CustomTextStyle.normal(AppColors.onBg),
            ),
            const Spacer(),
            Text(
              "${percentage * 100}%",
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
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.onBg.withOpacity(0.5),
                          offset: const Offset(
                            0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ]),
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
