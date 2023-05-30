import 'dart:convert';

class TrashBadge {
  String id;
  String displayImage;
  String condition;
  TrashBadge({
    required this.id,
    required this.displayImage,
    required this.condition,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayImage': displayImage,
      'condition': condition,
    };
  }

  factory TrashBadge.fromMap(Map<String, dynamic> map) {
    return TrashBadge(
      id: map['_id'] ?? '',
      displayImage: map['display_image'] ?? '',
      condition: map['condition'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TrashBadge.fromJson(String source) =>
      TrashBadge.fromMap(json.decode(source));
}
