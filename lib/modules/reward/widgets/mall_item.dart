import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

import '../../../core/values/app_assets/app_images.dart';

class MallItem extends StatelessWidget {
  final int point;
  final String image;
  final bool showPoint;
  final Function onTap;
  const MallItem(
      {super.key,
      required this.point,
      required this.image,
      this.showPoint = true,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Container(
            height: 132,
            width: 132,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primarySubtle),
            child: Image.network(image, fit: BoxFit.fill),
          ),
          if (showPoint)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(AppImages.trophy),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$point",
                    style: CustomTextStyle.title(AppColors.primary),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
