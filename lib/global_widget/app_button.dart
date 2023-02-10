import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/core/themes/app_colors.dart';

import '../core/themes/app_themes.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.buttonText,
      required this.onPressedFunction,
      this.color = AppColors.primary,
      this.textColor = AppColors.background});
  final String buttonText;
  final Color color;
  final Color textColor;
  final VoidCallback onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              side: color == AppColors.background
                  ? const BorderSide(width: 0.5, color: AppColors.info)
                  : BorderSide.none,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          onPressed: onPressedFunction,
          child: SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(buttonText,
                      style: CustomTextStyle.button(textColor))))),
    );
  }
}
