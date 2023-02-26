class RecentTrash {
  String id;
  String name;
  int count;
  RecentTrash({required this.id, required this.name, required this.count});
  factory RecentTrash.fromJson(Map<dynamic, dynamic> json) {
    return RecentTrash(
        id: json["id"], name: json["name"], count: json["count"] as int);
  }
}
