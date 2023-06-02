import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/reward.dart';
import 'package:sowaste/modules/reward/reward_controller.dart';
import 'package:sowaste/modules/reward/widgets/default_dialog.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

class TradeRewardDialog extends StatelessWidget {
  final Reward reward;
  const TradeRewardDialog({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.find<RewardController>();
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: Container(
        height: 480,
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
                reward.displayImage != ""
                    ? reward.displayImage
                    : "https://link.gdsc.app/XFblK6o",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 32),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Hurrah! You achieve an item. Show it at the recycling point for a ',
                    style: CustomTextStyle.bodyBold(Colors.black),
                  ),
                  TextSpan(
                    text: 'real-life reward',
                    style: CustomTextStyle.bodyBold(AppColors.primary),
                  ),
                ],
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
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                var isOk = await rewardController.addToBag(reward);
                if (!isOk) {
                  await defaultDialog(
                      title: "Error",
                      content: "Something went wrong, please try again later");
                } else {
                  Get.back();
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
                    "Add to bag".toUpperCase(),
                    style: CustomTextStyle.button(Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                await rewardController.updateUserPoint(reward.point);
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    )),
                child: Center(
                  child: Text(
                    "Exchange now".toUpperCase(),
                    style: CustomTextStyle.button(const Color(0xFF53565D)),
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
