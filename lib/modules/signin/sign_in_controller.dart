import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/routes/app_routes.dart';

class SignInController extends GetxController {
  TextEditingController name = TextEditingController(text: "");

  void navigateToFillInNameScreen() async {
    var response =
        await LocalService.readFile("${DataCenter.AppFilePath}/app.json");
    if (response != null) {
      AuthServices.idToken = response["idToken"];
      Get.toNamed(AppRoutes.base);
    } else {
      Get.toNamed(AppRoutes.enterUserNamePage);
    }
  }

  void navigateToSignInWithGoogleScreen() {
    Get.toNamed(AppRoutes.signInPage);
  }

  void signInAction() async {
    DataCenter.user = await AuthServices().signInWithGoogle();
    final displayName = name.text;
    // Cập nhật thông tin người dùng trên Firebase Authentication
    await DataCenter.user!.updateDisplayName(displayName);
    await HttpService.postRequestWithParam(
            parameters: {"uid": DataCenter.user!.uid}, url: UrlValue.createUser)
        .then((value) => print(value.body));

    LocalService.saveContent(
        {"idToken": DataCenter.user!.getIdToken().toString()},
        "${DataCenter.AppFilePath}/app.json");
  }
}
