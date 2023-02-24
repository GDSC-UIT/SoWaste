class DoneQuestions {
  DoneQuestions(
      {required this.questionId,
      required this.answerId,
      required this.correctAnswerId});
  String questionId;
  String answerId;
  String correctAnswerId;
}

class Progress {
  List<DoneQuestions>? doneQuestion;
  int currentQuestionIndex;
  String quizId;
  Progress({required this.currentQuestionIndex, required this.quizId});
}

class Quiz {
  String quizID;
  double result;
  Quiz({required this.quizID, required this.result});
}
