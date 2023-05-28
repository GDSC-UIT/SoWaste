import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import '../core/themes/app_themes.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.buttonText,
      required this.onPressedFunction,
      this.color = AppColors.primary,
      this.textColor = AppColors.background,
      this.ignore = false});
  final String buttonText;
  final Color color;
  final Color textColor;
  final VoidCallback onPressedFunction;
  final bool ignore;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: IgnorePointer(
            ignoring: ignore,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: (ignore ? AppColors.gray400 : color),
                    side: color == AppColors.background
                        ? const BorderSide(width: 0.3, color: AppColors.info)
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
          ),
        ));
  }
}
