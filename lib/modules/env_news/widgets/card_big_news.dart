import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_constant.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

class CardBigNews extends StatelessWidget {
  const CardBigNews({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    final EnvironmentNewsController environmentNewsController = Get.find();
    return GestureDetector(
      onTap: () => {environmentNewsController.getDetailArticle(article)},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppConst.borderRadius,
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
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
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
      ),
    );
  }
}
