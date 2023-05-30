import 'package:flutter/material.dart';
import 'package:sowaste/data/models/badge.dart';

import '../../../core/values/app_assets/app_images.dart';
import '../../../data/models/api_result.dart';
import '../../../data/services/reward_service.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RewardService.ins.getAllAppBadges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var result = snapshot.data;
          switch (result.runtimeType) {
            case EmptyResult:
              return Center(
                child: Image.asset(
                  AppImages.emptybag,
                  fit: BoxFit.fitHeight,
                ),
              );
            case ErrorResult:
              return Column(
                children: [
                  Container(height: 100),
                  Text(
                    (snapshot.data as ErrorResult).message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              );
            case FailedResult:
              return Column(
                children: [
                  Container(height: 100),
                  Text(
                    (snapshot.data as FailedResult).message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              );
            case SuccessResult:
              List<TrashBadge> appBadges =
                  (snapshot.data as SuccessResult).data;
              return GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                mainAxisSpacing: 24.0,
                crossAxisSpacing: 26.0,
                children: List.generate(
                  appBadges.length,
                  (index) => GridTile(
                    child: Image.network(
                      appBadges[index].displayImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
