import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/global_widget/markdown_text.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';

class EnvsNewsDetailScreen extends StatelessWidget {
  EnvsNewsDetailScreen({super.key});
  final EnvironmentNewsController _environmentNewsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const ArrowBackAppBar(
              isShowArrowBackIcon: true,
            ),
            body: Obx(() {
              if (_environmentNewsController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final Article article =
                    _environmentNewsController.currentArticle.value;
                return ListView(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 0, bottom: 8),
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
                      text: article.description!,
                    )
                  ],
                );
              }
            })));
  }
}
