import 'package:get/get.dart';
import 'package:sowaste/data/models/badge.dart';
import 'package:sowaste/data/models/reward.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/reward_service.dart';

import '../../core/utils/utils.dart';
import '../../data/models/api_result.dart';

class RewardController extends GetxController {
  List<Reward>? appRewards;
  Rx<List<Reward>?> userRewards = Rx<List<Reward>?>(null);
  List<TrashBadge>? appBadges;
  Rx<List<TrashBadge>?> userBadges = Rx<List<TrashBadge>?>(null);

  RxInt userPoint = RxInt(DataCenter.user?.point ?? 0);

  Future<ApiResult> postQrCode(String qrCode) async {
    if (isUrl(qrCode)) {
      return ErrorResult(message: "Invalid QR Code");
    }
    var res = await RewardService.ins.postQrCode(qrCode);
    if (res.runtimeType is SuccessResult) {
      DataCenter.user?.point += (res as SuccessResult).data as int;
      userPoint.value = DataCenter.user?.point ?? 0;
    }
    return res;
  }
}
