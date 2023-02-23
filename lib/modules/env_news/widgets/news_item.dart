import 'package:flutter/material.dart';
import 'package:sowaste/modules/env_news/env_news.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    super.key,
    required this.onTap,
    required this.envNews,
  });
  final EnvNews envNews;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
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
                    envNews.imgUrl,
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
                    envNews.title,
                    style: CustomTextStyle.bodyBold(AppColors.onBg),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    envNews.subtitle,
                    style: CustomTextStyle.normal(AppColors.onBg),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
