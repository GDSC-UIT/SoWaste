import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/services/data_center.dart';

import '../../data/models/trash.dart';

class HomeController extends GetxController {
  bool hasError = false;
  RxBool isLoading = false.obs;

  var articlesList = <Article>[].obs;
  var dictionary = <Trash>[].obs;
  RxInt totalDetectedObjects = 0.obs;
  @override
  void onInit() async {
    setColorForPieChart(0);
    updateTotalDetectedObjects();
    super.onInit();
  }

  void getDate() {}

  RxInt indexHasColor = 0.obs;

  Set<Color> colors = {};

  void setColorForPieChart(int index) {
    // print(
    //     "Detected Trash List length: ${DataCenter.recentDetectedTrashes.length}");
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
}
