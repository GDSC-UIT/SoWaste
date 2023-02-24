import 'package:sowaste/data/models/question.dart';

class Trash {
  String id;
  String name;
  bool isOrganic;
  bool isRecyable;
  String description;
  String displayImage;
  String uri;
  List<Question> questions;

  Trash(
      {required this.id,
      required this.description,
      required this.name,
      required this.isOrganic,
      required this.isRecyable,
      required this.displayImage,
      required this.uri,
      required this.questions});

  factory Trash.fromJson(Map<String, dynamic> json) {
    List<Question> temp = [];
    json["questions"].forEach((q) => temp.add(Question.fromJson(q)));
    return Trash(
        id: json["_id"],
        name: json["name"],
        isOrganic: json["is_organic"] as bool,
        isRecyable: json["recyable"] as bool,
        description: json["description"],
        uri: json["uri"],
        questions: temp,
        displayImage: json["display_image"]);
  }
}
