import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_icons.dart';
import 'package:get/get.dart';

class ToDicButton extends StatelessWidget {
  const ToDicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/dictionary');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You haven’t been learning any quizzes yet",
            style:
                CustomTextStyle.bodyBold(AppColors.onBg).copyWith(height: 1.5),
          ),
          Card(
            elevation: 10,
            child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Go to Trash Dictionary to learn more",
                            style: CustomTextStyle.bodyBold(AppColors.primary),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: AppColors.primary,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                    Flexible(child: Image.asset(AppIcons.dictionary))
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
