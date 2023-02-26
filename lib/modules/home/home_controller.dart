import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_file_path.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';

import '../../data/models/quiz.dart';
import '../../data/models/trash.dart';

class HomeController extends GetxController {
  bool hasError = false;
  RxBool isLoading = false.obs;

  var articlesList = <Article>[].obs;
  var dictionary = <Trash>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await fetchArticles();
    await fetchDictionary();
    await fetchQuestions();
    await fetchSavedTrashList();
    await fetchAllUserQuizzes();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> fetchAllUserQuizzes() async {
    for (var quiz in DataCenter.allQuizzes) {
      try {
        final response = await LocalService.readFile(
            "${AppFilePath.quizzes}_${quiz.quizId}");
        DataCenter.localQuizList.add(LocalQuiz.fromJson(response!));
        DataCenter.localQuizList.value = [...DataCenter.localQuizList];
      } catch (error) {}
    }
  }

  Future<void> fetchSavedTrashList() async {
    try {
      final response = await LocalService.readFile(AppFilePath.savedTrashes);
      if (response == null) return;
      DataCenter.savedTrashList.value = response["data"];
      print("Save List: $response");
    } catch (error) {
      isLoading.value = false;
      print("Has error when fetch saved trash list from local: $error");
    }
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await HttpService.getRequest(UrlValue.questionsUrl);
      final questionsJson =
          await json.decode(utf8.decode(response.bodyBytes))["data"];
      questionsJson
          .forEach((q) => DataCenter.questionList.add(Question.fromJson(q)));
      // add quiz per trash
      for (var trash in DataCenter.dictionary) {
        DataCenter.allQuizzes.add(Quiz.init(trash.id, trash.name));
      }
      print("All Quizzes: ${DataCenter.allQuizzes.length}");
    } catch (error) {
      print("Has Error when fetch all questions: $error");
      isLoading.value = false;
    }
  }

  Future<void> fetchArticles() async {
    final EnvironmentNewsController environmentNewsController =
        Get.put(EnvironmentNewsController());
    try {
      final response = await HttpService.getRequest(UrlValue.articlesUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((article) {
        articlesList.add(Article.fromJson(article));
      });
      DataCenter.news = [...articlesList];
      sortNews();
      environmentNewsController.news.value = [...DataCenter.news];
    } catch (error) {
      print("Error when fetch articles: $error");
      isLoading.value = false;
    }
  }

  Future<void> fetchDictionary() async {
    String id = "";
    try {
      final response = await HttpService.getRequest(UrlValue.dictionaryUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      print("Dictionary: $temp");
      temp.forEach((trash) {
        id = trash["_id"];
        dictionary.add(Trash.fromJson(trash));
      });
      print(dictionary);
      DataCenter.dictionary = [...dictionary];
    } catch (error) {
      print("Error in fetch dictionary: $error - id :$id");
      isLoading.value = false;
    }
  }

  void sortNews() {
    DataCenter.news.sort((a, b) => a.createAt.compareTo(b.createAt));
  }

  RxInt indexHasColor = 0.obs;
  RxInt count = 1.obs;

  List<Map<String, dynamic>> dummy_data = [
    {"category": "Food", "times": 1},
    {"category": "Paper", "times": 1},
    {"category": "Food Waste", "times": 2},
  ];

  Set<Color> colors = {};

  void setColorForPieChart(int index) {
    while (index != dummy_data.length) {
      colors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      index = colors.length;
      indexHasColor.value = index;
    }
  }
}
