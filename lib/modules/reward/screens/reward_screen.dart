import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/modules/reward/screens/badges_screen.dart';
import 'package:sowaste/modules/reward/screens/mall_screen.dart';
import 'package:sowaste/modules/reward/widgets/avatar_point.dart';
import 'package:sowaste/modules/reward/widgets/reward_appbar.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          RewardAppbar(),
          SizedBox(
            height: 10,
          ),
          AvatarPoint(
            point: 100,
            image:
                'https://i.pinimg.com/736x/27/96/c7/2796c781d37c99d6e0e7ba5d026ea476.jpg',
          ),
          SizedBox(
            height: 20,
          ),
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
                tabs: [
                  Tab(
                    text: 'Mall',
                  ),
                  Tab(
                    text: 'Badges',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              MallScreen(),
              BadgeScreen(),
            ]),
          )
        ],
      ),
    );
  }
}
