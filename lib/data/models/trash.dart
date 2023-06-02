import 'dart:convert';

import '../../core/values/app_url.dart';
import '../services/http_service.dart';

class Trash {
  String id;
  String name;
  String displayImage;
  Map<String, dynamic> nonReItems;
  Map<String, dynamic> reItems;
  List<dynamic>? types;
  String? goodToKnow;
  String? howToRe;
  bool? isOrganic;
  bool? isRecyable;
  String? shortDescription;

  Trash({
    required this.displayImage,
    required this.reItems,
    required this.nonReItems,
    this.shortDescription,
    this.types,
    this.goodToKnow,
    this.howToRe,
    required this.id,
    required this.name,
    this.isOrganic,
    this.isRecyable,
  });

  factory Trash.fromJson(Map<String, dynamic> json) {
    return Trash(
        id: json["_id"],
        name: json["name"],
        isOrganic: json["is_organic"] ?? false,
        isRecyable: json["recyable"] ?? false,
        shortDescription: json["short_description"] ?? "",
        displayImage: json["display_image"],
        types: json["types"] ?? [],
        goodToKnow: json["good_to_know"] ?? "",
        reItems:
            json["recyclable_items"] == {} ? null : json["recyclable_items"],
        nonReItems: json["non_recyclable_items"] == {}
            ? null
            : json["non_recyclable_items"],
        howToRe: json["how_to_recyclable"] ?? "");
  }

  static Future<Trash?> getTrash(String id) async {
    try {
      final response =
          await HttpService.getRequest("${UrlValue.dictionaryUrl}/$id");
      final trashJson = json.decode(utf8.decode(response.bodyBytes))["data"];
      return Trash.fromJson(trashJson);
    } catch (error) {
      print("ERROR: " + error.toString());
    } finally {}
    return null;
  }
}
