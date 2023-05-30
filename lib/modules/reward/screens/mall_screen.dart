import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/reward/reward_controller.dart';
import 'package:sowaste/modules/reward/screens/your_bag_screen.dart';
import 'package:sowaste/modules/reward/widgets/user_bag.dart';
import 'package:sowaste/modules/reward/widgets/app_reward_item.dart';
import 'package:sowaste/modules/reward/widgets/row_exchange.dart';

import '../../../core/themes/app_colors.dart';

class MallScreen extends StatelessWidget {
  const MallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.find<RewardController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Your Bag",
                  style: CustomTextStyle.subHeading(Colors.black),
                ),
                const Spacer(),
                Obx(() => ((rewardController.userRewards.length) > 3)
                    ? InkWell(
                        onTap: () => Get.to(() => const YourBagScreen()),
                        child: Row(
                          children: [
                            Text("See all",
                                style:
                                    CustomTextStyle.normal(AppColors.primary)),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Show items to the recycling point to redeem real-life items",
              style: CustomTextStyle.button(Colors.black),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              height: 150,
              child: UserBag(),
            ),
            const SizedBox(height: 38),
            const RowTitle(),
            const SizedBox(height: 16),
            const AppRewardItem(),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
