import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_file_name.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/models/quiz.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/data/models/trash.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';

class DataCenter extends GetxController {
  static bool isFirstTime = false;
  static List<Trash> dictionary = [];
  static List<Article> news = [];
  static String AppFilePath = "";
  static Map<dynamic, Set<String>> doneQuizId = {};
  static RxList<LocalQuiz> localQuizList = <LocalQuiz>[].obs;
  static List<Question> questionList = [];
  static RxList<dynamic> savedTrashList = [].obs;
  static RxList<Quiz> allQuizzes = <Quiz>[].obs;
  static RxList<dynamic> recentTrashes = [].obs;
  static String doneQuizzesFolder = "";
  static List<FileSystemEntity> listQuizFile = [];
  static RxList<dynamic> recentDetectedTrash = [].obs;
  static RxInt timesDeteted = 0.obs;

  static List<Map<String, dynamic>> dummy_data = [
    {
      "id": "63fadfc9838431f03d6a9896",
      "name": "Plastic Bottle",
      "count": 3,
      "date": "2023-03-01 20:14:55.005284"
    },
    {
      "id": "63fa0b7127309d844acd9a48",
      "name": "Bottle Cap",
      "count": 2,
      "date": "2023-03-01 20:21:49.779804"
    },
    {
      "id": "63fadccc838431f03d6a9895",
      "name": "Green/Garden Waste",
      "count": 1,
      "date": "2023-03-01 20:22:33.108370"
    },
    {
      "id": "63fadb42838431f03d6a9893",
      "name": "B3 Waste (Hazardous and Toxic Waste)",
      "count": 0,
      "date": "2023-03-01 20:25:26.719628"
    },
    {
      "id": "63fa0a2027309d844acd9a47",
      "name": "Glass Bottle",
      "count": 0,
      "date": "2023-03-01 20:27:03.823449"
    }
  ];

  static List<dynamic> getRecentDetectedTrashes() {
    final list =
        DataCenter.recentTrashes.where((trash) => trash["count"] != 0).toList();
    list.sort((a, b) => b["count"].compareTo(a["count"]));
    print("List after filter: ${list.length}");
    return list;
  }

  //isWithinAWeekBeforeToday and filter recent trash : Check if trash is searched or detected within a week then show up in recent trash
  static bool isWithinAWeekBeforeToday(String date) {
    DateTime d = DateTime.parse(date);
    var lastWeek = DateTime.now().add(const Duration(days: -7));
    if (d.compareTo(lastWeek) == 1) return true;
    return false;
  }

  static void filterRecentTrash() {
    DataCenter.recentTrashes.value = DataCenter.recentTrashes
        .where((trash) => isWithinAWeekBeforeToday(trash["date"]))
        .toList();
  }

  static Future<void> fetchRecentTrash() async {
    try {
      final response = await LocalService.readFile(
          "${DataCenter.AppFilePath}/${AppFileName.recentTrashes}");
      if (response == null) return;
      DataCenter.recentTrashes.value = response["data"];
      DataCenter.timesDeteted.value = response["times"];
      filterRecentTrash();
      print("Recent Trashes: ${DataCenter.recentTrashes}");
      print("Times: ${DataCenter.timesDeteted.value}");
      DataCenter.recentDetectedTrash.value = getRecentDetectedTrashes();
    } catch (error) {
      print("Has error when fetching recent trashes: $error");
    }
  }

  static Future<void> fetchAllUserQuizzes() async {
    print("Fetch user quiz");
    await LocalService.getAllFileDoneQuiz();
    for (var quizFile in DataCenter.listQuizFile) {
      print(quizFile.path);
      {
        try {
          final response = await LocalService.readFile(quizFile.path);
          DataCenter.localQuizList.add(LocalQuiz.fromJson(response!));
          print("Local quiz list length: ${DataCenter.localQuizList.length}");
        } catch (error) {}
      }
    }
  }

  static Future<void> fetchSavedTrashList() async {
    try {
      final response = await LocalService.readFile(
          "${DataCenter.AppFilePath}/${AppFileName.savedTrashes}");
      if (response == null) return;
      DataCenter.savedTrashList.value = response["data"];
      print("Save List: $response");
    } catch (error) {
      // isLoading.value = false;
      print("Has error when fetch saved trash list from local: $error");
    }
  }

  static Future<void> fetchQuestions() async {
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
    } catch (error) {
      print("Has Error when fetch all questions: $error");
      // isLoading.value = false;
    }
  }

  static Future<void> fetchArticles() async {
    final EnvironmentNewsController environmentNewsController =
        Get.put(EnvironmentNewsController());
    try {
      final response = await HttpService.getRequest(UrlValue.articlesUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((article) {
        DataCenter.news.add(Article.fromJson(article));
      });

      sortNews();
      environmentNewsController.news.value = [...DataCenter.news];
    } catch (error) {
      print("Error when fetch articles: $error");
      // isLoading.value = false;
    }
  }

  static Future<void> fetchDictionary() async {
    String id = "";
    try {
      final response = await HttpService.getRequest(UrlValue.dictionaryUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((trash) {
        id = trash["_id"];
        dictionary.add(Trash.fromJson(trash));
      });
      print(dictionary);
      DataCenter.dictionary = [...dictionary];
    } catch (error) {
      print("Error in fetch dictionary: $error - id :$id");
      // isLoading.value = false;
    }
  }

  static void sortNews() {
    DataCenter.news.sort((a, b) => a.createAt.compareTo(b.createAt));
  }

  RxInt indexHasColor = 0.obs;
  RxInt count = 1.obs;
}
