import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_icons.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/core/values/app_constant.dart';
import 'package:sowaste/modules/base/base_controller.dart';

class ToDicButton extends StatelessWidget {
  const ToDicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BaseController.changeIndexPage(1);
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
            shape: RoundedRectangleBorder(borderRadius: AppConst.borderRadius),
            elevation: 7,
            shadowColor: AppConst.shadowColor,
            child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Go to Waste Dictionary to learn more",
                            style: CustomTextStyle.bodyBold(AppColors.primary),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: AppColors.primary,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                    Flexible(flex: 2, child: Image.asset(AppImages.onboarding1))
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
