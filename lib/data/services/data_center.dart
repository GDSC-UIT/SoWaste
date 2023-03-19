import 'dart:convert';
import 'dart:io';
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
  static RxList<dynamic> recentDetectedTrashes = [].obs;
  static RxInt timesDeteted = 0.obs;

  static List<dynamic> getrecentDetectedTrasheses() {
    final list =
        DataCenter.recentTrashes.where((trash) => trash["count"] != 0).toList();
    list.sort((a, b) => b["count"].compareTo(a["count"]));
    // print("List after filter: ${list.length}");
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
      // print("Recent Trashes: ${DataCenter.recentTrashes}");
      // print("Times: ${DataCenter.timesDeteted.value}");
      DataCenter.recentDetectedTrashes.value = getrecentDetectedTrasheses();
    } catch (error) {
      // print("Has error when fetching recent trashes: $error");
    }
  }

  static Future<void> fetchAllUserQuizzes() async {
    // print("Fetch user quiz");
    await LocalService.getAllFileDoneQuiz();
    for (var quizFile in DataCenter.listQuizFile) {
      // print(quizFile.path);
      {
        try {
          final response = await LocalService.readFile(quizFile.path);
          DataCenter.localQuizList.add(LocalQuiz.fromJson(response!));
          // print("Local quiz list length: ${DataCenter.localQuizList.length}");
        } catch (error) {}
      }
    }
  }

  static Future<void> fetchSavedTrashes() async {
    try {
      final response = await LocalService.readFile(
          "${DataCenter.AppFilePath}/${AppFileName.savedTrashes}");
      if (response == null) return;
      DataCenter.savedTrashList.value = response["data"];
      // print("Save List: $response");
    } catch (error) {
      // print("Has error when fetch saved trash list from local: $error");
    }
  }

  static Future<void> fetchAllQuestions() async {
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
      // print("Has Error when fetch all questions: $error");
      // isLoading.value = false;
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

      sortNews();
      environmentNewsController.news.value = [...DataCenter.news];
    } catch (error) {
      // print("Error when fetch articles: $error");
      // isLoading.value = false;
    }
  }

  static Future<void> fetchDictionary() async {
    try {
      final response = await HttpService.getRequest(UrlValue.dictionaryUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((trash) {
        dictionary.add(Trash.fromJson(trash));
      });
      // print(dictionary);
      DataCenter.dictionary = [...dictionary];
    } catch (error) {
      // print("Error in fetch dictionary: $error - id :$id");

    }
  }

  static void sortNews() {
    DataCenter.news.sort((a, b) => b.createAt.compareTo(a.createAt));
  }
}
