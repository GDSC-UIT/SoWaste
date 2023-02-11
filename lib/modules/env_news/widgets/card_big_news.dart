import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import 'dart:math' as math;

class CardBigNews extends StatelessWidget {
  const CardBigNews({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.subtitle,
  });
  final String imgUrl;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 60,
            offset: Offset(0, 4),
            color: AppColors.dropShadow,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.network(
              imgUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 134,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.title(AppColors.onBg),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: CustomTextStyle.normal(AppColors.onBg),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "Read more ",
                        style: CustomTextStyle.normal(AppColors.primaryDark),
                      ),
                      Transform.rotate(
                        angle: math.pi * 1,
                        child: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: AppColors.primaryDark,
                          size: 15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
