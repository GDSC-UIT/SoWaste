import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';

import '../modules/base/base_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  final BaseController _baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: _baseController.currentIndex.value,
      cornerRadius: 10,
      onTap: (index) => _baseController.currentIndex.value = index,
      items: const [
        TabItem(
          icon: Icons.home,
          title: "Home",
        ),
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
