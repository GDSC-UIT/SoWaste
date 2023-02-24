import './option.dart';

class Question {
  String id;
  String title;
  String trashId;
  int point;
  List<Option>? options;
  Question(
      {required this.id,
      required this.title,
      required this.trashId,
      required this.point,
      required this.options});
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json["_id"],
        title: json["title"],
        trashId: json["dictionary_id"],
        point: json["point"] as int,
        options: json["options"]);
  }
}
