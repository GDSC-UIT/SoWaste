import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import '../modules/base/base_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    BaseController.tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      controller: BaseController.tabController,
      cornerRadius: 10,
      onTap: (index) => BaseController.changeIndexPage(index),
      items: const [
        TabItem(icon: Icons.home, title: "Home"),
        TabItem(icon: Icons.newspaper, title: "News"),
        TabItem(icon: Icons.camera_alt),
        TabItem(icon: Icons.book, title: "Dictionary"),
        TabItem(icon: Icons.location_on, title: "Around"),
      ],
      color: AppColors.info,
      style: TabStyle.fixedCircle,
      backgroundColor: AppColors.background,
      activeColor: AppColors.primary,
    );
  }
}
