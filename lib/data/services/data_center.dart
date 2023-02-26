import 'package:get/get.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/models/quiz.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/data/models/trash.dart';

import '../models/question.dart';

class DataCenter extends GetxController {
  static bool isFirstTime = false;
  static List<Trash> dictionary = [];
  static List<Article> news = [];
  static String appFilePath = "";
  static Map<dynamic, Set<String>> doneQuizId = {};
  static RxList<LocalQuiz> localQuizList = <LocalQuiz>[].obs;
  static List<Question> questionList = [];
  static RxList<dynamic> savedTrashList = [].obs;
  static RxList<Quiz> allQuizzes = <Quiz>[].obs;
}
