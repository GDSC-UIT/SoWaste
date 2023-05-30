import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_assets/app_images.dart';
import '../../../data/models/api_result.dart';
import '../../../data/services/reward_service.dart';
import '../reward_controller.dart';
import 'exchange_now_dialog.dart';
import 'mall_item.dart';

class UserBag extends StatelessWidget {
  const UserBag({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.find<RewardController>();
    return Obx(() => FutureBuilder(
          key: ValueKey(rewardController.futureKey.value),
          future: RewardService.ins.getAllUserRewards(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;
              switch (result.runtimeType) {
                case EmptyResult:
                  return Center(
                      child: Image.asset(AppImages.emptybag,
                          fit: BoxFit.fitHeight));
                case ErrorResult:
                  return Column(
                    children: [
                      Container(height: 100),
                      Text(
                        (result as ErrorResult).message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                case FailedResult:
                  return Column(
                    children: [
                      Container(height: 100),
                      Text((result as FailedResult).message,
                          style: const TextStyle(color: Colors.red)),
                    ],
                  );
                case SuccessResult:
                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: min(3, rewardController.userRewards.length),
                    itemBuilder: (context, index) {
                      return MallItem(
                        point: rewardController.userRewards[index].reward.point,
                        image: rewardController
                            .userRewards[index].reward.displayImage,
                        onTap: () => Get.dialog(ExchangeNowDialog(
                            userReward: rewardController.userRewards[index])),
                        showPoint: false,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 20),
                  );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
