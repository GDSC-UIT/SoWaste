class Option {
  String id;
  String description;
  String questionId;
  String trashId;
  bool isCorrect;
  Option(
      {required this.id,
      required this.description,
      required this.questionId,
      required this.trashId,
      required this.isCorrect});
  factory Option.fromJson(Map<dynamic, dynamic> json) {
    return Option(
        id: json["_id"],
        description: json["description"],
        questionId: json["question_id"],
        trashId: json["dictionary_id"],
        isCorrect: json["is_correct"]);
  }
}
