import 'package:sowaste/data/services/data_center.dart';

class QuizResult {
  String quizId;
  int userPoint;
  int totalQuizPoint;
  String name;
  String trashId;
  String shortDescription;

  QuizResult(
      {required this.name,
      required this.quizId,
      required this.totalQuizPoint,
      required this.userPoint,
      required this.trashId,
      required this.shortDescription});

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    var quizPoint = 0;
    var quiz = DataCenter.questionList
        .where((q) => q.trashId == json["dictionary_id"])
        .toList();
    for (var q in quiz) {
      quizPoint += q.point;
    }
    return QuizResult(
      quizId: json["_id"],
      trashId: json["dictionary_id"],
      totalQuizPoint: quizPoint,
      userPoint: json["total"],
      name: json["dictionary"][0]["name"],
      shortDescription: json["dictionary"][0]["short_description"],
    );
  }
}
