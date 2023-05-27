import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/themes/app_colors.dart';
import '../core/themes/app_themes.dart';

class ArrowBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ArrowBackAppBar(
      {super.key,
      this.title,
      this.isShowArrowBackIcon = true,
      this.onTap,
      this.action});
  final String? title;
  final bool isShowArrowBackIcon;
  final VoidCallback? onTap;
  final IconButton? action;
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      backgroundColor: AppColors.background,
      centerTitle: isShowArrowBackIcon,
      title: Text(
        title ?? "",
        style: CustomTextStyle.sub(AppColors.primary),
      ),
      leading: isShowArrowBackIcon
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.secondary,
              ),
              onPressed: onTap ?? () => {Get.back()})
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
