import 'dart:convert';

import '../../core/values/app_url.dart';
import '../services/http_service.dart';

class Trash {
  String id;
  String name;
  bool isOrganic;
  bool isRecyable;
  String? description;
  String displayImage;
  String uri;
  String shortDescription;

  Trash({
    required this.id,
    required this.name,
    required this.isOrganic,
    required this.isRecyable,
    required this.displayImage,
    required this.uri,
    required this.shortDescription,
    this.description,
  });

  factory Trash.fromJson(Map<String, dynamic> json) {
    return Trash(
        id: json["_id"],
        name: json["name"],
        isOrganic: json["is_organic"] as bool,
        isRecyable: json["recyable"] as bool,
        description: json["description"],
        uri: json["uri"],
        shortDescription: json["short_description"],
        displayImage: json["display_image"]);
  }

  static Future<Trash?> getTrash(String id) async {
    try {
      final response =
          await HttpService.getRequest("${UrlValue.dictionaryUrl}/$id");
      final trashJson = json.decode(utf8.decode(response.bodyBytes))["data"];
      return Trash.fromJson(trashJson);
    } catch (error) {
      print("Failed to fetch a trash: $error");
    } finally {}
  }
}
