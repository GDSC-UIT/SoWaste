import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import 'dart:math' as math;

class CardBigNews extends StatelessWidget {
  const CardBigNews({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    final EnvironmentNewsController environmentNewsController = Get.find();
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
              article.displayImage,
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
                    article.title,
                    style: CustomTextStyle.title(AppColors.onBg),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    article.shortDescription,
                    style: CustomTextStyle.normal(AppColors.onBg),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          environmentNewsController.getDetailArticle(article)
                        },
                        child: Text(
                          "Read more ",
                          style: CustomTextStyle.normal(AppColors.primaryDark),
                        ),
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
