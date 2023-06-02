import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/user.dart';
import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/signin/sign_in_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => TempScreenState();
}

class TempScreenState extends State<TempScreen> {
  @override
  void initState() {
    LocalService.readFile("${DataCenter.AppFilePath}/app.json").then((value) {
      if (value != null) {
        AuthServices().navigateToFillInNameScreen();
      } else {
        Get.offAndToNamed(AppRoutes.onboardingPage);
      }
    }).catchError((error) {
      Get.offAndToNamed(AppRoutes.onboardingPage);
      print("ERROR: " + error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.primary,
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "SoWaste",
          style: CustomTextStyle.h2(Colors.white),
          textAlign: TextAlign.center,
        ),
        Text(
          "Sort smarter, not harder",
          style: CustomTextStyle.bodyBold(Colors.white),
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
