import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';

import '../../../core/themes/app_colors.dart';

class QrCodeResultDialog extends StatelessWidget {
  final int point;
  const QrCodeResultDialog({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Container(
        height: 433,
        width: 384,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              AppImages.happyEarth,
              height: 160,
              width: 114,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            Text(
              "Hurrah! You’ve received ",
              style: CustomTextStyle.large(Colors.black),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  point.toString(),
                  style: CustomTextStyle.subHeading(AppColors.primary),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  height: 24,
                  width: 15.5,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(AppImages.trophy),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: AppColors.primary,
                ),
                child: Center(
                  child: Text(
                    "Continue".toUpperCase(),
                    style: CustomTextStyle.button(Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
