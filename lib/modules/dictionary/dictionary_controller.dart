import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_file_path.dart';
import 'package:sowaste/data/models/question.dart';
import 'package:sowaste/data/models/quiz_local.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/local_data.dart';

import '../../data/models/trash.dart';

class DictionaryController extends GetxController {
  TextEditingController searchInput = TextEditingController();
  RxBool isLoading = false.obs;
  Rx<List<Trash>> foundWords = Rx<List<Trash>>([]);

  RxString currentQuizId = ''.obs;
  RxList<Question> currentQuiz = <Question>[].obs; // quiz fetch from api
  RxInt currentQuestionIndex = 0.obs;
  RxInt userAnswer = 0.obs;
  RxInt currentPoint = 0.obs;
  RxBool isFinishedQuiz = false.obs;
  RxString currentTrashName = "".obs;
  RxString currentTrashShortDescription = "".obs;

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

  Future<void> saveTrash(Trash t) async {
    print("Trash is saved: ${isSaved.value}");
    if (!isSaved.value) {
      DataCenter.savedTrashList.add({"id": t.id, "name": t.name});
      print("Data after add: ${DataCenter.savedTrashList}");
    } else {
      DataCenter.savedTrashList.removeAt(indexTrashToRemove.value);
      print("Data after remove: ${DataCenter.savedTrashList}");
    }
    final response = await LocalService.saveContent(
        {"data": DataCenter.savedTrashList}, AppFilePath.savedTrashes);
    isSaved.value = !isSaved.value;
    print("Data after clicked Save! $response");
    DataCenter.savedTrashList.value = [...DataCenter.savedTrashList];
  }

  RxInt count = 0.obs;
  void initAllValuesForCurrentQuiz([point = 0, index = 0]) {
    currentPoint.value = point;
    currentQuestionIndex.value = index;
    if (currentPoint.value == 0 && currentQuestionIndex.value == 0) {
      doneQuestions.value = [];
    }
  }

  Future<void> postQuizToLocal() async {
    localQuiz.quizId = currentQuizId.value;
    localQuiz.numberOfDoneQues = currentQuestionIndex.value + 1;
    localQuiz.point = currentPoint.value;
    localQuiz.totalQuizPoint = getTotalPoint();
    localQuiz.doneQuestions = doneQuestions;
    localQuiz.name = currentTrashName.value;
    localQuiz.shortDescription = currentTrashShortDescription.value;

    print("LocalQuiz: ${localQuiz.toJson()}");
    await LocalService.saveContent(
        localQuiz.toJson(), "${AppFilePath.quizzes}_${localQuiz.quizId}");
    DataCenter.localQuizList
        .removeWhere((quiz) => quiz.quizId == localQuiz.quizId);
    DataCenter.localQuizList.add(localQuiz);
    DataCenter.localQuizList.value = [...DataCenter.localQuizList];
  }

  Future<void> getQuizFromLocal() async {
    final response = await LocalService.readFile(
        "${AppFilePath.quizzes}_${currentQuizId.value}");
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
}
