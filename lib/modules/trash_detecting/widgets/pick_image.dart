import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({super.key, required this.img, required this.text});
  final String img;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                img,
                height: 60,
                width: 60,
              ),
              Text(
                text,
                style: CustomTextStyle.normal(AppColors.onBg),
              ),
            ],
          ),
        ));
  }
}
