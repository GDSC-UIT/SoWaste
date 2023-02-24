import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                "3 hours ago",
                style: CustomTextStyle.normal(AppColors.onBg),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
