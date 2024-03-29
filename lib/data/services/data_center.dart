import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_file_name.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/models/quiz.dart';
import 'package:sowaste/data/models/trash.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';
import '../models/user.dart';

class DataCenter extends GetxController {
  static UserModel? user;
  static bool isFirstTime = false;
  static List<Trash> dictionary = [];
  static RxList<Article> news = <Article>[].obs;
  static String AppFilePath = "";
  static Map<dynamic, Set<String>> doneQuizId = {};
  static List<Question> questionList = [];
  static RxList<dynamic> savedTrashList = [].obs;
  static RxList<Quiz> allQuizzes = <Quiz>[].obs;
  static RxList<dynamic> recentTrashes = [].obs;
  static String doneQuizzesFolder = "";
  static RxList<dynamic> recentDetectedTrashes = [].obs;
  static RxInt timesDeteted = 0.obs;

  static List<dynamic> getrecentDetectedTrasheses() {
    final list =
        DataCenter.recentTrashes.where((trash) => trash["count"] != 0).toList();
    list.sort((a, b) => b["count"].compareTo(a["count"]));
    return list;
  }

  //isWithinAWeekBeforeToday and filter recent trash : Check if trash is searched or detected within a week then show up in recent trash
  static bool isWithinAWeekBeforeToday(String date) {
    DateTime d = DateTime.parse(date);
    var lastWeek = DateTime.now().add(const Duration(days: -7));
    if (d.compareTo(lastWeek) == 1) return true;
    return false;
  }

  static void filterRecentTrashes() {
    DataCenter.recentTrashes.value = DataCenter.recentTrashes
        .where((trash) => isWithinAWeekBeforeToday(trash["date"]))
        .toList();
  }

  static Future<void> fetchRecentTrashes() async {
    try {
      final response = await LocalService.readFile(
          "${DataCenter.AppFilePath}/${AppFileName.recentTrashes}");
      if (response == null) return;
      DataCenter.recentTrashes.value = response["data"];
      DataCenter.timesDeteted.value = response["times"];
      filterRecentTrashes();
      DataCenter.recentDetectedTrashes.value = getrecentDetectedTrasheses();
    } catch (error) {}
  }

  static Future<void> fetchSavedTrashes() async {
    try {
      final response = await LocalService.readFile(
          "${DataCenter.AppFilePath}/${AppFileName.savedTrashes}");
      if (response == null) return;
      DataCenter.savedTrashList.value = response["data"];
    } catch (error) {}
  }

  static Future<void> fetchAllQuestions() async {
    questionList = [];
    try {
      final response = await HttpService.getRequest(UrlValue.questionsUrl);
      final questionsJson =
          await json.decode(utf8.decode(response.bodyBytes))["data"];

      var count = 0;

      questionsJson.forEach((q) {
        ++count;
        DataCenter.questionList.add(Question.fromJson(q));
      });
      // add quiz per trash
      print("COUNT QUESTIONS: " + count.toString());
    } catch (error) {
      print("ERROR WHEN FECTH QUESTION: " + error.toString());
      ;
    }
  }

  static Future<void> fetchAllArticles() async {
    final EnvironmentNewsController environmentNewsController =
        Get.put(EnvironmentNewsController());
    try {
      final response = await HttpService.getRequest(UrlValue.articlesUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((article) {
        DataCenter.news.add(Article.fromJson(article));
      });
      DataCenter.news.value = [...DataCenter.news];
      sortNews();
      environmentNewsController.news.value = [...DataCenter.news];
    } catch (error) {
      log(error.toString());
    }
  }

  static Future<void> fetchDictionary() async {
    try {
      final response = await HttpService.getRequest(UrlValue.dictionaryUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((trash) {
        dictionary.add(Trash.fromJson(trash));
      });
    } catch (error) {
      print(UrlValue.dictionaryUrl);
      log(error.toString());
    }
  }

  static void sortNews() {
    DataCenter.news.sort((a, b) => b.createAt.compareTo(a.createAt));
  }
}
