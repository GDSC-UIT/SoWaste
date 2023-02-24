class Option {
  String id;
  String description;
  String questionId;
  String trashId;
  bool? isCorrect;
  Option({
    required this.id,
    required this.description,
    required this.questionId,
    required this.trashId,
  });
}
