import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class Empty extends StatelessWidget {
  const Empty({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.face_outlined,
              size: 80,
              color: AppColors.onBg.withOpacity(0.5),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Yout haven't $text",
              textAlign: TextAlign.center,
              style: CustomTextStyle.large(AppColors.onBg.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
