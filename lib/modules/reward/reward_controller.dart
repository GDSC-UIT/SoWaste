import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/badge.dart';
import 'package:sowaste/data/models/reward.dart';
import 'package:sowaste/data/models/user_reward.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/reward_service.dart';
import 'package:sowaste/modules/reward/widgets/default_dialog.dart';
import 'package:sowaste/modules/reward/widgets/trade_reward_dialog.dart';

import '../../core/utils/utils.dart';
import '../../data/models/api_result.dart';

class RewardController extends GetxController {
  List<Reward>? appRewards;
  RxInt futureKey = 0.obs;
  RxList<UserReward> userRewards = RxList<UserReward>([]);
  bool firstLoadUserRewards = true;

  List<TrashBadge>? appBadges;
  RxList<TrashBadge> userBadges = RxList<TrashBadge>([]);
  bool firstLoadUserBadges = true;

  RxInt userPoint = RxInt(DataCenter.user?.point ?? 0);

  Future<ApiResult> postQrCode(String qrCode) async {
    if (isUrl(qrCode)) {
      return ErrorResult(message: "Invalid QR Code");
    }
    var res = await RewardService.ins.postQrCode(qrCode);
    if (res is SuccessResult) {
      DataCenter.user?.point += (res).data as int;
      userPoint.value = DataCenter.user?.point ?? 0;
    }
    return res;
  }

  Future<void> tradeItem(Reward reward) async {
    if (userPoint.value < reward.point) {
      await defaultDialog(
        title: "Failed",
        content: "You don't have enough point to trade this item",
      );
      return;
    }
    await Get.dialog(TradeRewardDialog(reward: reward));
  }

  Future<bool> addToBag(Reward reward) async {
    EasyLoading.show(status: "Loading...");
    var res = await RewardService.ins.createUserExchange(reward.id);
    EasyLoading.dismiss();
    if (res is String) {
      userRewards.add(UserReward(id: res, reward: reward));
      futureKey.value += 1;
      userPoint.value -= reward.point;
      DataCenter.user?.point = userPoint.value;
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateUserPoint(int rewardPoint) async {
    EasyLoading.show(status: "Loading...");
    var success = await RewardService.ins.updateUserPoint(rewardPoint);
    EasyLoading.dismiss();
    if (success) {
      userPoint.value -= rewardPoint;
      DataCenter.user?.point = userPoint.value;
    } else {
      await defaultDialog(
        title: "Error",
        content: "Something went wrong, please try again later",
      );
    }
  }

  Future<bool> deleteUserReward(String userRewardId) async {
    EasyLoading.show(status: "Loading...");
    var success = await RewardService.ins.deleteUserExchange(userRewardId);
    EasyLoading.dismiss();
    if (success) {
      userRewards.removeWhere((item) => item.id == userRewardId);
      if (userRewards.isEmpty) futureKey.value += 1;
      return true;
    } else {
      return false;
    }
  }
}
