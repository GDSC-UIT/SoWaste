import 'package:sowaste/data/models/question.dart';

import '../services/data_center.dart';

class Quiz {
  String quizId;
  String quizName;
  List<Question> questions;
  Quiz({required this.quizId, required this.questions, required this.quizName});

  factory Quiz.init(String id, String name) {
    final quiz = DataCenter.questionList.where((q) => q.trashId == id).toList();
    // print("Quiz id: $id");
    return Quiz(quizId: id, questions: quiz, quizName: name);
  }
}
