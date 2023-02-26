import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import '../../../routes/app_routes.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final EnvironmentNewsController environmentNewsController = Get.find();
    return GestureDetector(
      onTap: () async {
        environmentNewsController.getDetailArticle(article);
      },
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
                    article.displayImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    article.title,
                    style: CustomTextStyle.bodyBold(AppColors.onBg),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    article.shortDescription,
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
