import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class Empty extends StatelessWidget {
  const Empty({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.face_outlined,
            size: 76,
            color: AppColors.onBg,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Yout haven't $text",
            style: CustomTextStyle.h4(AppColors.onBg),
          ),
        ],
      ),
    );
  }
}
