import 'package:get/get.dart';
import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/routes/app_page.dart';
import 'package:sowaste/routes/app_routes.dart';

class SignInController extends GetxController {
  void navigateToFillInNameScreen() {
    Get.toNamed(AppRoutes.enterUserNamePage);
  }

  void navigateToSignInWithGoogleScreen() {
    Get.toNamed(AppRoutes.signInPage);
  }

  void signInAction() async {
    await AuthServices().signInWithGoogle();
    Get.toNamed(AppRoutes.homeScreen);
  }
}
