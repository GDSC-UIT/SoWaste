import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/reward/screens/qr_screen.dart';

class RewardAppbar extends StatelessWidget {
  const RewardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          "Rewards",
          style: CustomTextStyle.heading(),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.qr_code,
            color: AppColors.primaryDark,
          ),
          onPressed: () => Get.to(() => const QrScreen()),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
