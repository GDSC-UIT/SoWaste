import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_file_name.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/local_data.dart';

import '../../data/models/trash.dart';
import '../../routes/app_routes.dart';

class DictionaryController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController searchInput = TextEditingController();
  RxList<Trash> foundWords = <Trash>[].obs;

  RxList<Question> currentQuiz = <Question>[].obs; // quiz fetch from api
  RxInt currentQuestionIndex = 0.obs;
  RxInt userAnswer = 0.obs;
  RxInt currentPoint = 0.obs;
  RxBool isFinishedQuiz = false.obs;

  //Trash
  Rx<Trash> currentTrash = Trash(
          id: "",
          name: "",
          isOrganic: false,
          isRecyable: false,
          displayImage: "",
          uri: "",
          shortDescription: "")
      .obs;
  //For local logic
  RxList<LocalQuestion> doneQuestions = <LocalQuestion>[].obs;
  LocalQuiz localQuiz = LocalQuiz(doneQuestions: []);

  //For save trash
  RxBool isSaved = false.obs;
  RxInt indexTrashToRemove = 0.obs;

  @override
  void onInit() {
    foundWords.value = [];
    super.onInit();
  }

  Future<void> getDetailTrash(String id) async {
    isLoading.value = true;
    Get.toNamed(AppRoutes.trashDetailPage, arguments: id);
    currentTrash.value = (await Trash.getTrash(id))!;
    initCurrentQuiz(id);
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
    }
    foundWords.value = result;
  }

  Future<void> saveTrash(Trash t) async {
    // print("Trash will be saved: ${isSaved.value}");
    if (!isSaved.value) {
      DataCenter.savedTrashList.add({"id": t.id, "name": t.name});
      // print("Data after add: ${DataCenter.savedTrashList}");
    } else {
      DataCenter.savedTrashList.removeAt(indexTrashToRemove.value);
      // print("Data after remove: ${DataCenter.savedTrashList}");
    }
    final response = await LocalService.saveContent(
        {"data": DataCenter.savedTrashList},
        "${DataCenter.AppFilePath}/${AppFileName.savedTrashes}");
    isSaved.value = !isSaved.value;
    // print("Data after clicked Save! $response");
    DataCenter.savedTrashList.value = [...DataCenter.savedTrashList];
  }

  RxInt count = 0.obs;
  void initAllValuesForCurrentQuiz([point = 0, index = 0]) {
    isFinishedQuiz.value = false;
    currentPoint.value = point;
    currentQuestionIndex.value = index;
    if (currentPoint.value == 0 && currentQuestionIndex.value == 0) {
      doneQuestions.value = [];
    }
  }

  Future<void> postQuizToLocal() async {
    localQuiz.quizId = currentTrash.value.id;
    localQuiz.numberOfDoneQues = currentQuestionIndex.value + 1;
    localQuiz.point = currentPoint.value;
    localQuiz.totalQuizPoint = getTotalPoint();
    localQuiz.doneQuestions = doneQuestions;
    localQuiz.name = currentTrash.value.name;
    localQuiz.shortDescription = currentTrash.value.shortDescription;

    // print("LocalQuiz: ${localQuiz.toJson()}");

    await LocalService.saveContent(localQuiz.toJson(),
        "${DataCenter.doneQuizzesFolder}/${localQuiz.quizId}.json");
    DataCenter.localQuizList
        .removeWhere((quiz) => quiz.quizId == localQuiz.quizId);
    DataCenter.localQuizList.add(localQuiz);
    DataCenter.localQuizList.value = [...DataCenter.localQuizList];
    DataCenter.allQuizzes.value = [...DataCenter.allQuizzes];
  }

  Future<void> getQuizFromLocal() async {
    final response = await LocalService.readFile(
        "${DataCenter.doneQuizzesFolder}/${currentTrash.value.id}.json");
    if (response != null) {
      localQuiz = LocalQuiz.fromJson(response);
      initAllValuesForCurrentQuiz(localQuiz.point, localQuiz.numberOfDoneQues);
      //check if finish when the number of done questions are equal to number of question in real quiz.
      isFinishedQuiz.value =
          (localQuiz.numberOfDoneQues == getNumberOfQuestion());
    } else {
      initAllValuesForCurrentQuiz();
    }
  }

  void initCurrentQuiz(String trashId) {
    currentQuiz.value =
        DataCenter.questionList.where((q) => q.trashId == trashId).toList();
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

  int getNumberOfQuestion() {
    return currentQuiz.length;
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
}
