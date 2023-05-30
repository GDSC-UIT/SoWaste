import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_file_name.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/diy.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/models/quiz_result.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';
import 'package:sowaste/data/services/local_data.dart';

import '../../data/models/trash.dart';
import '../../routes/app_routes.dart';

class DictionaryController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isFinishedQuiz = false.obs;

  TextEditingController searchInput = TextEditingController();
  RxList<Trash> foundTrash = <Trash>[].obs;
  RxList<DIY> diyList = <DIY>[].obs;

  RxList<Question> currentQuiz = <Question>[].obs; // quiz fetch from api
  RxInt currentQuestionIndex = 0.obs;
  RxInt userAnswer = 0.obs;
  RxInt totalPoint = 0.obs;

  RxList<Trash> savedTrashList = <Trash>[].obs;
  RxList<QuizResult> doneQuizList = <QuizResult>[].obs;
  Set<String> setDoneQuizTrashId = {};

  //Trash
  Rx<Trash> currentTrash =
      Trash(id: "", name: "", displayImage: "", nonReItems: {}, reItems: {})
          .obs;
  //For local logic
  // RxList<LocalQuestion> doneQuestions = <LocalQuestion>[].obs;
  // LocalQuiz localQuiz = LocalQuiz(doneQuestions: []);

  //For save trash
  RxBool isSaved = false.obs;

  RxList<DIY> currentDIYList = <DIY>[].obs;

  @override
  void onInit() async {
    await Future.wait([
      DataCenter.fetchDictionary(),
      DataCenter.fetchAllQuestions(),
    ]);
    await Future.wait([
      fetchSavedTrashList(),
      fetchAllDIY(),
      setDoneQuizList(),
    ]);

    foundTrash.value = [...DataCenter.dictionary];
    super.onInit();
  }

  Future<void> getDetailTrash(String id) async {
    isLoading.value = true;
    currentDIYList.value = [];
    for (DIY d in diyList) {
      if (d.trashId == id) {
        currentDIYList.add(d);
      }
    }
    Get.toNamed(AppRoutes.trashDetailPage, arguments: id);
    currentTrash.value = (await Trash.getTrash(id))!;
    initCurrentQuiz();
    postRecentTrashToLocalStorage();
    isLoading.value = false;
  }

  void filterWord(String word) {
    List<Trash> result = [];
    if (word.isNotEmpty) {
      result = DataCenter.dictionary
          .where((e) => e.name
              .toLowerCase()
              .contains(searchInput.value.text.toLowerCase()))
          .toList();
      foundTrash.value = result;
    } else {
      foundTrash.value = [...DataCenter.dictionary];
    }
  }

  Future<void> fetchSavedTrashList() async {
    List<Trash> result = [];
    var response =
        await HttpService.getRequest("${UrlValue.appUrl}/api/saved/user");
    final listJson = await json.decode(utf8.decode(response.bodyBytes))["data"];
    if (listJson != null) {
      listJson.forEach((e) {
        result.add(Trash.fromJson(e["dictionary"][0]));
      });
    }
    savedTrashList.value = result;
  }

  Future<void> saveTrash(Trash t) async {
    //nếu save
    if (!isSaved.value) {
      await HttpService.postRequestWithParam(
          parameters: {"dictionary_id": t.id},
          url: "${UrlValue.appUrl}/api/saved");
    } else {
      await HttpService.deleteRequest(
          url: "${UrlValue.appUrl}/api/saved/user/${currentTrash.value.id}");
    }
    isSaved.value = !isSaved.value;
    await fetchSavedTrashList();
  }

  RxInt count = 0.obs;
  void initCurrentQuiz() {
    totalPoint.value = 0;
    currentQuestionIndex.value = 0;
    userAnswer.value = 0;
    currentQuiz.value = DataCenter.questionList
        .where((q) => q.trashId == currentTrash.value.id)
        .toList();
  }

  Future<void> postQuizResult() async {
    //xet truong hop post va put quiz
    //1. Neu quiz lam roi -> put
    //2. Neu quiz chua lam -> post
    if (setDoneQuizTrashId.contains(currentTrash.value.id)) {
      var data = {"total": totalPoint.value};
      String id = "";
      for (QuizResult q in doneQuizList) {
        if (q.trashId == currentTrash.value.id) {
          id = q.quizId;
          break;
        }
      }
      final response = await HttpService.putRequest(
          body: json.encode(data),
          url: "${UrlValue.appUrl}/api/quiz-result/$id");
      if (json.decode(response.body) != null) {
        setDoneQuizList();
      }
    } else {
      var data = {
        "dictionary_id": currentTrash.value.id,
        "total": totalPoint.value
      };
      final response = await HttpService.postRequest(
          body: json.encode(data), url: "${UrlValue.appUrl}/api/quiz-result");
      if (response.body.isNotEmpty) {
        setDoneQuizList();
      }
    }
  }

  void addPoint(int point) {
    totalPoint.value += point;
  }

  int getTotalPoint() {
    int total = 0;
    for (int i = 0; i < currentQuiz.length; ++i) {
      total += currentQuiz[i].point;
    }
    return total;
  }

  Future<void> postRecentTrashToLocalStorage({bool isDetected = false}) async {
    final int index = DataCenter.recentTrashes.indexWhere(
        (recentTrash) => recentTrash["id"] == currentTrash.value.id);
    if (index >= 0) {
      if (isDetected) ++DataCenter.recentTrashes[index]["count"];
      DataCenter.recentTrashes[index]["date"];
    } else {
      DataCenter.recentTrashes.add({
        "id": currentTrash.value.id,
        "name": currentTrash.value.name,
        "count": isDetected ? 1 : 0, // number of times that user detect trash
        "date": DateTime.now().toString()
      });
    }
    await LocalService.saveContent({
      "times": DataCenter.timesDeteted.value,
      "data": DataCenter.recentTrashes
    }, "${DataCenter.AppFilePath}/${AppFileName.recentTrashes}");
    DataCenter.recentTrashes.value = [...DataCenter.recentTrashes];
    DataCenter.recentDetectedTrashes.value =
        DataCenter.getrecentDetectedTrasheses();
  }

  Future<void> setDoneQuizList() async {
    var result = [];
    setDoneQuizTrashId = {};
    var response =
        await HttpService.getRequest("${UrlValue.appUrl}/api/quiz-result");
    final responseJson =
        await json.decode(utf8.decode(response.bodyBytes))["data"];
    if (responseJson != null) {
      responseJson.forEach((json) {
        result.add(QuizResult.fromJson(json));
        setDoneQuizTrashId.add(json["dictionary_id"]);
      });
    }
    doneQuizList.value = [...result];
  }

  Future<void> fetchAllDIY() async {
    var result = [];
    try {
      final response =
          await HttpService.getRequest("${UrlValue.appUrl}/api/diy");
      print("RESPONSE: " + response.body);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((d) {
        result.add(DIY.fromJson(d));
      });
      diyList.value = [...result];
    } catch (error) {
      print("ERROR IN FETCH DIY: " + error.toString());
    }
  }

  late Rx<DIY> currentDIY = DIY(
          trashId: "",
          id: "",
          title: "",
          shortDescription: "",
          createAt: DateTime.now(),
          displayImage: "")
      .obs;

  Future<void> getDIYDetails(String id) async {
    isLoading.value = true;
    Get.toNamed(AppRoutes.diyDetailPage, arguments: id);
    currentDIY.value = await DIY.getDIY(id);
    isLoading.value = false;
  }
}
