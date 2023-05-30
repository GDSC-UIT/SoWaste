import 'dart:convert';

import 'package:sowaste/data/models/reward.dart';

class UserReward {
  String id;
  Reward reward;
  UserReward({
    required this.id,
    required this.reward,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'reward': reward.toMap(),
    };
  }

  factory UserReward.fromMap(Map<String, dynamic> map) {
    return UserReward(
      id: map['_id'] ?? '',
      reward: Reward.fromMap(map['reward'][0]),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReward.fromJson(String source) =>
      UserReward.fromMap(json.decode(source));
}
