import 'dart:convert';

import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/services/http_service.dart';

class DIY extends Article {
  String trashId;
  DIY(
      {required this.trashId,
      required super.id,
      required super.title,
      required super.shortDescription,
      required super.createAt,
      required super.displayImage,
      super.description});
  factory DIY.fromJson(Map<String, dynamic> json) {
    return DIY(
      trashId: json["dictionary_id"],
      id: json["_id"],
      title: json["title"],
      description: json["description"] ?? "",
      shortDescription: json["short_description"],
      createAt: DateTime.parse(json["created_at"]),
      displayImage: json["display_image"],
    );
  }

  static Future<DIY> getDIY(String id) async {
    final response =
        await HttpService.getRequest("${UrlValue.appUrl}/api/diy/$id");
    final diyJson = json.decode(utf8.decode(response.bodyBytes))["data"]["diy"];

    return DIY.fromJson(diyJson);
  }
}
