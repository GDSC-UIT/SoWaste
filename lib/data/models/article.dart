class Article {
  String id;
  String title;
  String description;
  String shortDescription;
  String source;
  DateTime createAt;
  String displayImage;

  Article(
      {required this.id,
      required this.title,
      required this.description,
      required this.shortDescription,
      required this.source,
      required this.createAt,
      required this.displayImage});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      shortDescription: json["short_description"],
      source: json["source"],
      createAt: DateTime.parse(json["created_at"]),
      displayImage: json["display_image"],
    );
  }
}
