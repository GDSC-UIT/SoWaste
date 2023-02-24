import 'package:sowaste/data/models/question.dart';

class Quiz {
  String quizId;
  List<Question> questions;
  Quiz({required this.quizId, required this.questions});
}
