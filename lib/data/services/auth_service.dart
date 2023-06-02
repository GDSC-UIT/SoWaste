import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/user.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/routes/app_routes.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _ggSignIn = GoogleSignIn();
  static late String? idToken;
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? ggSignInAccount = await _ggSignIn.signIn();
      if (ggSignInAccount != null) {
        final GoogleSignInAuthentication ggSignInAuthen =
            await ggSignInAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: ggSignInAuthen.accessToken,
          idToken: ggSignInAuthen.idToken,
        );

        // Lấy thông tin người dùng đã xác thực
        // Xác thực với Firebase sử dụng thông tin xác thực của Google
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // Lấy thông tin người dùng đã xác thực
        final User? user = userCredential.user;
        idToken = await user!.getIdToken();
        return user;
      }
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException $e");
    } catch (e) {
      log(e.toString());
    }
  }

  signOut() async {
    await _auth.signOut();
    await _ggSignIn.signOut().then((value) async {
      DataCenter.user = null;
      await LocalService.clearContent("${DataCenter.AppFilePath}/app.json");
      Get.offAllNamed(AppRoutes.signInPage);
    });
  }

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

  static User? get currentUser => FirebaseAuth.instance.currentUser;
  static bool isLoggedIn() => FirebaseAuth.instance.currentUser != null;
}
