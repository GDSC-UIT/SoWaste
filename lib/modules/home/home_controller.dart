import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/models/trash.dart';
import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/base/base_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

class HomeController extends GetxController {
  RxList<Article> news = <Article>[].obs;
  RxList<Trash> saveTrashList = <Trash>[].obs;

  @override
  void onInit() async {
    super.onInit();
    DataCenter.doneQuizzesFolder =
        await LocalService.createFolderInAppDocDir("quizzes");
    await Future.wait([
      DataCenter.fetchAllArticles(),
      DataCenter.fetchRecentTrashes(),
    ]);
    news.value = [...DataCenter.news];
    setColorForPieChart(0);
    updateTotalDetectedObjects();
  }

  bool hasError = false;
  RxBool isLoading = false.obs;

  var articlesList = <Article>[].obs;
  RxInt totalDetectedObjects = 0.obs;

  RxInt indexHasColor = 0.obs;

  Set<Color> colors = {};

  void setColorForPieChart(int index) {
    while (index != DataCenter.recentDetectedTrashes.length) {
      colors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      index = colors.length;
      indexHasColor.value = index;
    }
  }

  void updateTotalDetectedObjects() {
    int sum = 0;
    for (var trash in DataCenter.recentDetectedTrashes) {
      sum += trash["count"] as int;
    }
    totalDetectedObjects.value = sum;
  }

  void navigateToProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  void navigateToReward() {
    BaseController.changeIndexPage(4);
  }
}
