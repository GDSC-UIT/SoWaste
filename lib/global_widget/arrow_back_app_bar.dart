import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../core/themes/app_colors.dart';
import '../core/themes/app_themes.dart';

class ArrowBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ArrowBackAppBar(
      {super.key, this.title, this.isShowArrowBackIcon = true, this.onTap});
  final String? title;
  final bool isShowArrowBackIcon;
  final VoidCallback? onTap;
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      backgroundColor: AppColors.background,
      title: Text(
        title ?? "",
        style: CustomTextStyle.sub(AppColors.secondary),
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
