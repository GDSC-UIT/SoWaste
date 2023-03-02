import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_file_name.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

import '../../data/models/quiz.dart';
import '../../data/models/trash.dart';

class HomeController extends GetxController {
  bool hasError = false;
  RxBool isLoading = false.obs;

  var articlesList = <Article>[].obs;
  var dictionary = <Trash>[].obs;
  RxInt totalTimesDetecting = 0.obs;
  @override
  void onInit() async {
    setColorForPieChart(0);
    updateTotalTimesDetecting();
    super.onInit();
  }

  void getDate() {}

  RxInt indexHasColor = 0.obs;
  RxInt count = 1.obs;

  Set<Color> colors = {};

  void setColorForPieChart(int index) {
    print(
        "Detected Trash List length: ${DataCenter.recentDetectedTrash.length}");
    while (index != DataCenter.recentDetectedTrash.length) {
      colors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      index = colors.length;
      indexHasColor.value = index;
    }
  }

  void updateTotalTimesDetecting() {
    int sum = 0;
    for (var trash in DataCenter.recentDetectedTrash) {
      sum += trash["count"] as int;
    }
    totalTimesDetecting.value = sum;
  }
}
