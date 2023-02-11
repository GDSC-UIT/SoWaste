import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
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
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 60,
            offset: Offset(0, 4),
            color: AppColors.dropShadow,
          ),
        ],
      ),
      height: 120,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: CustomTextStyle.bodyBold(AppColors.onBg),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: CustomTextStyle.normal(AppColors.onBg),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
