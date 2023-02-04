import 'package:get/get.dart';
import 'package:sowaste/modules/home/home_controller.dart';
import 'package:sowaste/modules/onboarding/onboarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
