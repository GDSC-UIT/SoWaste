import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';

import '../reward_controller.dart';

class AvatarPoint extends StatelessWidget {
  final String image;
  const AvatarPoint({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.find<RewardController>();
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180),
            color: Colors.grey,
            image: DecorationImage(image: NetworkImage(image)),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 21, height: 30, child: Image.asset(AppImages.trophy)),
            const SizedBox(
              width: 8,
            ),
            Obx(() => Text(
                  "${rewardController.userPoint.value}",
                  style: CustomTextStyle.sub(AppColors.primary),
                ))
          ],
        )
      ],
    );
  }
}
