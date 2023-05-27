import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/routes/app_routes.dart';

class SignInController extends GetxController {
  TextEditingController name = TextEditingController(text: "");

  void navigateToFillInNameScreen() {
    Get.toNamed(AppRoutes.enterUserNamePage);
  }

  void navigateToSignInWithGoogleScreen() {
    Get.toNamed(AppRoutes.signInPage);
  }

  void signInAction() async {
    User user = await AuthServices().signInWithGoogle();
    print("DISPLAY NAME: " + name.text);
    final displayName = name.text;
    // Cập nhật thông tin người dùng trên Firebase Authentication
    await user.updateDisplayName(displayName);
    if (AuthServices.isLoggedIn()) Get.toNamed(AppRoutes.base);
  }
}
