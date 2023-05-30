import 'dart:developer';

import 'package:get/get.dart';
import 'package:sowaste/core/utils/extension.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/reward.dart';
import 'package:sowaste/data/services/http_service.dart';

import '../../modules/reward/reward_controller.dart';
import '../models/api_result.dart';
import '../models/badge.dart';
import '../models/user_reward.dart';

class RewardService {
  static final RewardService ins = RewardService._initInstance();

  RewardService._initInstance();

  final rewardController = Get.find<RewardController>();

  Future<ApiResult> getAllAppRewards() async {
    if (rewardController.appRewards != null) {
      if (rewardController.appRewards?.isEmpty ?? true) {
        return EmptyResult();
      }
      return SuccessResult(data: rewardController.appRewards);
    }
    var res = await HttpService.getRequest(UrlValue.getAllAppRewardsUrl);
    try {
      if (res.isOk) {
        var listMapReward = res.data;
        if (listMapReward == null) {
          rewardController.appRewards = [];
          return EmptyResult();
        }
        rewardController.appRewards =
            List.from(listMapReward.map((json) => Reward.fromMap(json)));
        return SuccessResult(data: rewardController.appRewards);
      }
    } catch (e) {
      log(e.toString());
      return ErrorResult(message: e.toString());
    }
    return FailedResult(message: res.message);
  }

  Future<ApiResult> getAllUserRewards() async {
    if (!rewardController.firstLoadUserRewards) {
      if (rewardController.userRewards.isEmpty) {
        return EmptyResult();
      }
      return SuccessResult(data: rewardController.userRewards);
    }
    var res = await HttpService.getRequest(UrlValue.getAllUserRewardsUrl);
    try {
      if (res.isOk) {
        rewardController.firstLoadUserRewards = false;
        var listMapReward = res.data;
        if (listMapReward == null) {
          rewardController.userRewards.value = [];
          return EmptyResult();
        }
        rewardController.userRewards.value =
            List.from(listMapReward.map((json) => UserReward.fromMap(json)));
        return SuccessResult(data: rewardController.userRewards);
      }
    } catch (e) {
      log(e.toString());
      return ErrorResult(message: e.toString());
    }
    return FailedResult(message: res.message);
  }

  Future<ApiResult> getAllAppBadges() async {
    if (rewardController.appBadges != null) {
      if (rewardController.appBadges?.isEmpty ?? true) {
        return EmptyResult();
      }
      return SuccessResult(data: rewardController.appBadges);
    }
    var res = await HttpService.getRequest(UrlValue.getAllAppBadgesUrl);
    try {
      if (res.isOk) {
        var listMapBadge = res.data;
        if (listMapBadge == null) {
          rewardController.appBadges = [];
          return EmptyResult();
        }
        rewardController.appBadges =
            List.from(listMapBadge.map((json) => TrashBadge.fromMap(json)));
        return SuccessResult(data: rewardController.appBadges);
      }
    } catch (e) {
      log(e.toString());
      return ErrorResult(message: e.toString());
    }
    return FailedResult(message: res.message);
  }

  Future<ApiResult?> getAllUserBadges() async {
    if (!rewardController.firstLoadUserBadges) {
      if (rewardController.userBadges.isEmpty) {
        return EmptyResult();
      }
      return SuccessResult(data: rewardController.userBadges);
    }
    var res = await HttpService.getRequest(UrlValue.getAllUserBadgesUrl);
    try {
      if (res.isOk) {
        rewardController.firstLoadUserBadges = false;
        var listMapBadge = res.data;
        if (listMapBadge == null) {
          rewardController.userBadges.value = [];
          return EmptyResult();
        }
        rewardController.userBadges.value =
            List.from(listMapBadge.map((json) => TrashBadge.fromMap(json)));
        return SuccessResult(data: rewardController.userBadges);
      }
    } catch (e) {
      log(e.toString());
      return ErrorResult(message: e.toString());
    }
    return FailedResult(message: res.message);
  }

  Future<ApiResult> postQrCode(String qrCode) async {
    var res =
        await HttpService.postRequest(url: "${UrlValue.postQrCodeUrl}/$qrCode");
    try {
      if (res.isOk) {
        if (res.data == null) {
          return EmptyResult();
        }
        return SuccessResult(data: res.data["QR"]["point"]);
      }
    } catch (e) {
      log(e.toString());
      return ErrorResult(message: e.toString());
    }
    return FailedResult(message: res.message);
  }

  Future<dynamic> createUserExchange(String rewardId) async {
    var res = await HttpService.postRequest(
        url: "${UrlValue.createUserExchangeUrl}?reward_id=$rewardId");
    try {
      if (res.isOk) {
        return res.data["exchange"]["_id"];
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> updateUserPoint(int rewardPoint) async {
    var res = await HttpService.putRequestWithParam(parameters: {
      'action': 'decrease',
      'point': rewardPoint.toString(),
    }, url: UrlValue.updateUserPointUrl);
    try {
      if (res.isOk) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> deleteUserExchange(String rewardId) async {
    var res = await HttpService.deleteRequest(
        url: "${UrlValue.deleteUserExchangeUrl}/$rewardId");
    try {
      if (res.isOk) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
