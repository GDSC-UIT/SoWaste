import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sowaste/data/models/reward.dart';

import '../../../core/values/app_assets/app_images.dart';
import '../../../data/models/api_result.dart';
import '../../../data/services/reward_service.dart';
import 'mall_item.dart';

class UserBag extends StatelessWidget {
  const UserBag({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RewardService.ins.getAllUserRewards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var result = snapshot.data;
          switch (result.runtimeType) {
            case EmptyResult:
              return Center(
                child: Image.asset(
                  AppImages.emptybag,
                  fit: BoxFit.fitHeight,
                ),
              );
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
            case SuccessResult:
              List<Reward> userRewards = (result as SuccessResult).data;
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: min(3, userRewards.length),
                itemBuilder: (context, index) {
                  return MallItem(
                    point: userRewards[index].point,
                    image: userRewards[index].displayImage,
                    showPoint: false,
                  );
                },
              );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
