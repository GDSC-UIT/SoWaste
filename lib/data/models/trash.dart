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
  List<String>? types;
  String? goodToKnow;
  List<String>? nonReItems;
  List<String>? reItems;
  String? howToRe;

  Trash(
      {required this.id,
      required this.name,
      required this.isOrganic,
      required this.isRecyable,
      required this.displayImage,
      required this.uri,
      required this.shortDescription,
      this.description,
      this.types,
      this.goodToKnow,
      this.reItems,
      this.nonReItems,
      this.howToRe});

  factory Trash.fromJson(Map<String, dynamic> json) {
    return Trash(
        id: json["_id"],
        name: json["name"],
        isOrganic: json["is_organic"] as bool,
        isRecyable: json["recyable"] as bool,
        description: json["description"],
        uri: json["uri"],
        shortDescription: json["short_description"],
        displayImage: json["display_image"],
        types: json["types"] != null ? json["types"] as List<String> : null,
        goodToKnow: json["good_to_know"],
        reItems: json["types"] != null
            ? json["recyclable_items"] as List<String>
            : null,
        nonReItems: json["types"] != null
            ? json["non_recyclable_items"] as List<String>
            : null,
        howToRe: json["how_to_recyclable"]);
  }

  static Future<Trash?> getTrash(String id) async {
    try {
      final response =
          await HttpService.getRequest("${UrlValue.dictionaryUrl}/$id");
      final trashJson = json.decode(utf8.decode(response.bodyBytes))["data"];
      return Trash.fromJson(trashJson);
    } catch (error) {
    } finally {}
    return null;
  }
}
