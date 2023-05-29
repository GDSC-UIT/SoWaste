import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/services/reward_service.dart';
import 'package:sowaste/modules/reward/reward_controller.dart';

import '../../../data/models/api_result.dart';
import 'mall_item.dart';

class AppRewardItem extends StatelessWidget {
  const AppRewardItem({super.key});

  @override
  Widget build(BuildContext context) {
    final rewartController = Get.find<RewardController>();

    return FutureBuilder(
      future: RewardService.ins.getAllAppRewards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var result = snapshot.data;
          switch (result.runtimeType) {
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
                  Text(
                    (result as FailedResult).message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              );
            case EmptyResult:
              return Column(
                children: [
                  Container(height: 100),
                  const Text(
                    "We don't have any rewards yet!",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              );
            case SuccessResult:
              final appRewards = (result as SuccessResult).data;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appRewards?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 120 / 177,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return MallItem(
                    point: appRewards?[index].point ?? -999,
                    image: appRewards?[index].displayImage ??
                        "https://link.gdsc.app/XFblK6o",
                  );
                },
              );
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 80),
            const CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
