import 'dart:convert';

class Reward {
  String id;
  String displayImage;
  int point;
  Reward({
    required this.id,
    required this.displayImage,
    required this.point,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayImage': displayImage,
      'point': point,
    };
  }

  factory Reward.fromMap(Map<String, dynamic> map) {
    return Reward(
      id: map['_id'] ?? '',
      displayImage: map['display_image'] ?? '',
      point: map['point']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reward.fromJson(String source) => Reward.fromMap(json.decode(source));
}
