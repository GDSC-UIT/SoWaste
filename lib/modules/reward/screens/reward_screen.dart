import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/modules/reward/widgets/avatar_point.dart';
import 'package:sowaste/modules/reward/widgets/reward_appbar.dart';

import '../../../data/services/data_center.dart';
import '../reward_controller.dart';
import 'badges_screen.dart';
import 'mall_screen.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final rewardController = Get.put(RewardController());

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25),
          const RewardAppbar(),
          const SizedBox(height: 10),
          AvatarPoint(
            image: DataCenter.user?.displayImage ??
                "https://link.gdsc.app/juIO30l",
          ),
          const SizedBox(height: 20),
          Container(
            width: screenWidth * (388 / 428),
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.gray300),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TabBar(
                controller: tabController,
                labelColor: Colors.white,
                indicatorColor: AppColors.primaryDark,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                tabs: const [
                  Tab(text: 'Mall'),
                  Tab(text: 'Badges'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                MallScreen(),
                BadgeScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
