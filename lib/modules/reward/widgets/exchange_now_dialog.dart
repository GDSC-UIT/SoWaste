import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import '../../../data/models/user_reward.dart';
import '../reward_controller.dart';

class ExchangeNowDialog extends StatelessWidget {
  final UserReward userReward;
  const ExchangeNowDialog({super.key, required this.userReward});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.find<RewardController>();
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: Container(
        height: 336,
        width: 384,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 96,
              width: 89,
              child: Image.network(
                userReward.reward.displayImage,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              """
Attention: By clicking "EXCHANGE NOW", this means you received the real-life reward from recycling points, and SoWaste will remove it from your bag.
""",
              style: CustomTextStyle.button(AppColors.secondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: () async {
                var success =
                    await rewardController.deleteUserReward(userReward.id);
                if (success) {
                  Get.back();
                } else {
                  Get.back();
                  Get.snackbar("Error", "Something went wrong");
                }
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: AppColors.primary,
                ),
                child: Center(
                  child: Text(
                    "Exchange now".toUpperCase(),
                    style: CustomTextStyle.button(Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
