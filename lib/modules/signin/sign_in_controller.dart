import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/user.dart';

import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/routes/app_routes.dart';

class SignInController extends GetxController {
  TextEditingController name = TextEditingController(text: "");

  Future<void> setUserInfo() async {
    try {
      final response =
          await HttpService.getRequest("${UrlValue.appUrl}/api/user");
      print("RESPONSE BODY: " + response.body);
      final responseJson =
          await json.decode(utf8.decode(response.bodyBytes))["data"];
      DataCenter.user = UserModel.fromJson(responseJson);
    } catch (error) {
      print("ERROR IN SET USER INFO: " + error.toString());
    }
  }

  void navigateToFillInNameScreen() async {
    var response =
        await LocalService.readFile("${DataCenter.AppFilePath}/app.json");
    if (response != null) {
      AuthServices.idToken = response["idToken"];
      print("AUTH IDTOKEN: " + AuthServices.idToken!);
      await setUserInfo();
      log("CHECK USER: " + DataCenter.user!.name);
      Get.offAndToNamed(AppRoutes.base);
    } else {
      Get.toNamed(AppRoutes.enterUserNamePage);
    }
  }

  void navigateToSignInWithGoogleScreen() {
    Get.toNamed(AppRoutes.signInPage);
  }

  void signInAction() async {
    try {
      log("AUTH ACTION");
      User? user = await AuthServices().signInWithGoogle();
      final displayName = name.text;
      // Cập nhật thông tin người dùng trên Firebase Authentication
      await user?.updateDisplayName(displayName);
      await HttpService.postRequestWithParam(
              parameters: {"uid": user!.uid}, url: UrlValue.createUser)
          .then((value) => log(value.body));
      await setUserInfo();
      await LocalService.saveContent({"idToken": AuthServices.idToken},
          "${DataCenter.AppFilePath}/app.json");
      Get.offAndToNamed(AppRoutes.base);
    } catch (error) {
      log("ERROR WHEN SIGN IN: " + error.toString());
    }
  }
}
