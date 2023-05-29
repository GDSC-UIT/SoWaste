import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

Future defaultDialog({required String title, required String content}) async {
  return await Get.defaultDialog(
    barrierDismissible: false,
    title: title,
    content: Text(content),
    confirm: TextButton(
      onPressed: () => Get.back(),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(
            "Ok".toUpperCase(),
            style: CustomTextStyle.button(Colors.white),
          ),
        ),
      ),
    ),
  );
}
