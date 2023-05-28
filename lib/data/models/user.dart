class UserModel {
  String id;
  String name;
  String email;
  int point;
  String displayImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.point,
    required this.displayImage, // Initialize displayImage with an empty string as the default value
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["_id"] ?? "",
        name: json["full_name"] ?? "",
        email: json["email"] ?? "",
        point: json["reward_point"] ?? 0,
        displayImage: json["display_image"] ?? "");
  }
}
