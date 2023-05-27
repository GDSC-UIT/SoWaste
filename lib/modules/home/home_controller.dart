import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/local_data.dart';

import '../../data/models/trash.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    print(AuthServices.currentUser!.displayName.toString());
    DataCenter.doneQuizzesFolder =
        await LocalService.createFolderInAppDocDir("quizzes");
    await Future.wait([
      LocalService.getAllFileDoneQuiz(),
      DataCenter.fetchDictionary(),
      DataCenter.fetchAllQuestions(),
      DataCenter.fetchAllArticles(),
      DataCenter.fetchSavedTrashes(),
      DataCenter.fetchAllUserQuizzes(),
      DataCenter.fetchRecentTrashes(),
    ]);

    setColorForPieChart(0);
    updateTotalDetectedObjects();
  }

  bool hasError = false;
  RxBool isLoading = false.obs;

  var articlesList = <Article>[].obs;
  var dictionary = <Trash>[].obs;
  RxInt totalDetectedObjects = 0.obs;

  void getDate() {}

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
}
