class LocalQuestion {
  String questionId;
  String optionId;
  bool isCorrect; // if user  chose correct answer : true;
  LocalQuestion(
      {required this.questionId,
      required this.optionId,
      required this.isCorrect});
  factory LocalQuestion.fromJson(Map<dynamic, dynamic> json) {
    return LocalQuestion(
        questionId: json["question_id"],
        optionId: json["option_id"],
        isCorrect: json["is_correct"]);
  }
}

class LocalQuiz {
  String? quizId;
  int? numberOfDoneQues =
      0; // number of done Questions = index of next question
  int? point;
  int? totalQuizPoint;
  List<LocalQuestion> doneQuestions;
  String? name;
  String? shortDescription;

  LocalQuiz(
      {this.quizId,
      this.numberOfDoneQues,
      this.point,
      this.totalQuizPoint,
      required this.doneQuestions,
      this.name,
      this.shortDescription});

  factory LocalQuiz.fromJson(Map<dynamic, dynamic> json) {
    List<LocalQuestion> localQuestionList = <LocalQuestion>[];

    json["done_questions"]
        .forEach((q) => localQuestionList.add(LocalQuestion.fromJson(q)));
    return LocalQuiz(
        quizId: json["quiz_id"],
        name: json["name"],
        numberOfDoneQues: json["number_of_done_questions"],
        point: json["point"],
        totalQuizPoint: json["total_quiz_point"],
        doneQuestions: localQuestionList,
        shortDescription: json["short_description"]);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "quiz_id": quizId,
      "number_of_done_questions": numberOfDoneQues,
      "point": point,
      "total_quiz_point": totalQuizPoint,
      "name": name,
      "short_description": shortDescription,
      "done_questions": List<dynamic>.from(doneQuestions.map((e) => {
            "question_id": e.questionId,
            "option_id": e.optionId,
            "is_correct": e.isCorrect,
          }))
    };
  }
}
