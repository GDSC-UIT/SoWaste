import 'package:get/get.dart';
import 'package:sowaste/modules/reward/reward_controller.dart';

class RewardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RewardController>(() => RewardController());
  }
}
