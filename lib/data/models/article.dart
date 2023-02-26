import 'dart:convert';

import '../../core/values/app_url.dart';
import '../services/http_service.dart';

class Article {
  String id;
  String title;
  String? description;
  String shortDescription;
  String source;
  DateTime createAt;
  String displayImage;

  Article(
      {required this.id,
      required this.title,
      required this.shortDescription,
      required this.source,
      required this.createAt,
      required this.displayImage,
      this.description});

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
  static Future<Article> getArticle(String id) async {
    final response =
        await HttpService.getRequest("${UrlValue.articlesUrl}/$id");
    final articleJson = json.decode(utf8.decode(response.bodyBytes))["data"];
    return Article.fromJson(articleJson);
  }
}
