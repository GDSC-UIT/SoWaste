import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/services/data_center.dart';

import '../../core/values/app_url.dart';
import '../../data/models/quiz.dart';
import '../../data/models/trash.dart';
import '../../data/services/http_service.dart';

class DictionaryController extends GetxController {
  TextEditingController searchInput = TextEditingController();
  RxBool isLoading = false.obs;
  Rx<List<Trash>> foundWords = Rx<List<Trash>>([]);
  RxList<Question> currentQuiz = <Question>[].obs;
  RxInt currentQuestionIndex = 0.obs;
  RxInt userAnswer = 0.obs;
  RxInt currentPoint = 0.obs;
  RxInt numberOfUserRightAnswer = 0.obs;
  // RxList allQuestionsJson = [].obs;

  @override
  void onInit() {
    foundWords.value = [];
    super.onInit();
  }

  void filterWord(String word) {
    List<Trash> result = [];
    if (word.isNotEmpty) {
      result = DataCenter.dictionary
          .where((e) =>
              e.name.toLowerCase().contains(searchInput.text.toLowerCase()))
          .toList();
    }
    foundWords.value = result;
  }

  RxInt count = 0.obs;

  Future<dynamic> getAllQuestionsJson(String trashId) async {
    try {
      print("Is Loading");
      isLoading.value = true;
      //allQuestions: get trash to have all questions
      final trash =
          await HttpService.getRequest("${UrlValue.dictionaryUrl}/$trashId");
      //allQuestionsJson: decode to json all questions.
      final allQuestionsJson = await json
          .decode(utf8.decode(trash.bodyBytes))["data"][0]["questions"];
      print("All Questions: $allQuestionsJson");
      return allQuestionsJson;
    } catch (error) {
      print("Error to fetch all questions");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrenQuiz(String trashId) async {
    final response = await getAllQuestionsJson(trashId);
    if (currentQuiz.isEmpty) {
      for (int i = 0; i < response.length; ++i) {
        try {
          final question = await HttpService.getRequest(
              "${UrlValue.questionsUrl}/${response[i]["_id"]}");
          final questionJson =
              await json.decode(utf8.decode(question.bodyBytes))["data"];
          print("Question: $questionJson");

          currentQuiz.add(Question.fromJson(questionJson));
        } catch (error) {
          print("Fail to fetch option: $error");
        }
      }
    }
  }

  void addPoint(int point) {
    currentPoint.value += point;
  }

  int getTotalPoint() {
    int total = 0;
    for (int i = 0; i < currentQuiz.length; ++i) {
      total += currentQuiz[i].point;
    }
    return total;
  }
}
