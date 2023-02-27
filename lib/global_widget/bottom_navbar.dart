import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/routes/app_routes.dart';

import '../modules/base/base_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key, this.selectedIndex});
  final int? selectedIndex;
  final BaseController _baseController = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: selectedIndex,
      cornerRadius: 10,
      onTap: (index) => _baseController.currentIndex.value = index,
      items: [
        const TabItem(icon: Icons.home),
        const TabItem(icon: Icons.newspaper),
        TabItem(
            icon: RawMaterialButton(
          onPressed: () async {
            try {
              await ImageServices.getImageFromCamera();
              _baseController.currentIndex.value = 2;
              // Get.toNamed(AppRoutes.detectPage);
            } catch (error) {}
          },
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
      color: AppColors.info,
      style: TabStyle.fixedCircle,
      backgroundColor: AppColors.background,
      activeColor: AppColors.primary,
    );
  }
}
