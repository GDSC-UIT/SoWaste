import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/routes/app_routes.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          final a = await Article.getArticle(article.id);
          Get.toNamed(AppRoutes.envNewsDetailedPage, arguments: a);
        },
        child: SizedBox(
          width: 170,
          height: 200,
          child: Card(
              shadowColor: AppColors.onBg.withOpacity(0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(8),
              elevation: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                      width: 180,
                      child: Image(
                        image: NetworkImage(article.displayImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        article.title,
                        style: CustomTextStyle.link(AppColors.onBg),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
