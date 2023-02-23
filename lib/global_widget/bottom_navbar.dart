import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/modules/base/base_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final baseController = Get.find<BaseController>();
    return ConvexAppBar(
      cornerRadius: 10,
      items: [
        const TabItem(icon: Icons.home),
        const TabItem(icon: Icons.newspaper),
        TabItem(
            icon: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: AppColors.primaryDark,
          padding: const EdgeInsets.all(15.0),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.camera_alt_rounded,
            color: AppColors.background,
          ),
        )),
        const TabItem(icon: Icons.book),
        const TabItem(icon: Icons.location_on),
      ],
      onTap: (index) => baseController.currentIndex.value = index,
      initialActiveIndex: 1,
      color: AppColors.info,
      style: TabStyle.fixedCircle,
      backgroundColor: AppColors.background,
      activeColor: AppColors.primary,
    );
  }
}
