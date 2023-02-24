import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/global_widget/markdown_text.dart';

class EnvsNewsDetailtedScreen extends StatelessWidget {
  EnvsNewsDetailtedScreen({super.key});
  final Article article = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.secondary,
            ),
            onPressed: () => {Get.back()},
          ),
        ),
        body: ListView(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
          children: [
            SizedBox(
              height: context.height * 0.2,
              width: double.infinity,
              child: Image.network(
                article.displayImage,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              article.title,
              style: CustomTextStyle.sub(AppColors.onBg),
            ),
            const SizedBox(height: 8),
            Text(
              GetTimeAgo.parse(article.createAt),
              style: CustomTextStyle.normal(AppColors.onBg),
            ),
            const SizedBox(height: 16),
            Text(
              article.shortDescription,
              style: CustomTextStyle.bodyBold(AppColors.onBg),
            ),
            const SizedBox(height: 16),
            MarkdownText(
              text: article.description,
            )
          ],
        ),
      ),
    );
  }
}
