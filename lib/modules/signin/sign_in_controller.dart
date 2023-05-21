import 'package:get/get.dart';
import 'package:sowaste/routes/app_routes.dart';

class SignInController extends GetxController {
  void navigateToFillInNameScreen() {
    Get.toNamed(AppRoutes.enterUserNamePage);
  }

  void navigateToSignInWithGoogleScreen() {
    Get.toNamed(AppRoutes.signInPage);
  }
}
