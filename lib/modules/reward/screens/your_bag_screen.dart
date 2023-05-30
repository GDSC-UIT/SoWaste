import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/reward/reward_controller.dart';
import 'package:sowaste/modules/reward/widgets/exchange_now_dialog.dart';

import '../widgets/mall_item.dart';

class YourBagScreen extends StatelessWidget {
  const YourBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.find<RewardController>();
    final userRewards = rewardController.userRewards;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.secondary,
            size: 25,
          ),
        ),
        title: Text(
          "Your Bag",
          style: CustomTextStyle.subHeading(AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Obx(() {
          return GridView.builder(
            itemCount: userRewards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 120 / 142,
              crossAxisSpacing: 14,
              mainAxisSpacing: 18,
            ),
            itemBuilder: (context, index) {
              return MallItem(
                point: userRewards[index].reward.point,
                image: userRewards[index].reward.displayImage,
                showPoint: false,
                onTap: () => Get.dialog(
                    ExchangeNowDialog(userReward: userRewards[index])),
              );
            },
          );
        }),
      ),
    );
  }
}
