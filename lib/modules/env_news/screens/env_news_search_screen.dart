import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/bottom_navbar.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';
import '../../../core/themes/app_colors.dart';
import '../widgets/card_big_news.dart';
import '../widgets/news_item.dart';

class EnvNewsSearchScreen extends StatelessWidget {
  EnvNewsSearchScreen({
    super.key,
  });
  final EnvironmentNewsController _environmentNewsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 1,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.secondary,
                    ),
                    onPressed: () => {Get.back()},
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 60,
                            offset: Offset(0, 4),
                            color: AppColors.dropShadow,
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (_) =>
                            {_environmentNewsController.filterArticle()},
                        controller:
                            _environmentNewsController.searchInput.value,
                        decoration: InputDecoration.collapsed(
                          hintText: "Find your interested news here...",
                          hintStyle: CustomTextStyle.normal(AppColors.info),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.height * 0.045),
            Obx(() => _environmentNewsController.searchInput.value.text == ""
                ? CardBigNews(
                    article: DataCenter.news[DataCenter.news.length - 1])
                : Container()),
            const SizedBox(height: 24),
            Container(
              constraints: BoxConstraints(maxHeight: context.height * 0.8),
              child: Obx(
                () => ListView.separated(
                  itemBuilder: (_, index) => NewsItem(
                    article: _environmentNewsController.news[index],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: _environmentNewsController.news.length,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
