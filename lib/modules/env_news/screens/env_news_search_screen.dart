import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/global_widget/search_input.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';

import '../widgets/card_big_news.dart';
import '../widgets/news_item.dart';

class EnvironmentNewsOverviewScreen extends StatelessWidget {
  EnvironmentNewsOverviewScreen({
    super.key,
  });
  final EnvironmentNewsController _environmentNewsController =
      Get.put(EnvironmentNewsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const ArrowBackAppBar(
        isShowArrowBackIcon: false,
        title: "Environment News",
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AppSearchInput(
                controller: _environmentNewsController.searchInput.value,
                onChangeFunction: (String value) {
                  if (value == "") {
                    _environmentNewsController.showBigCard.value = true;
                  } else {
                    _environmentNewsController.showBigCard.value = false;
                  }
                  _environmentNewsController.filterArticle();
                },
                deleteInput: () {
                  _environmentNewsController.showBigCard.value = true;
                  _environmentNewsController.news.value = [...DataCenter.news];
                },
              ),
            ),
            Obx(
              () => _environmentNewsController.showBigCard.value
                  ? const SizedBox(height: 24)
                  : SizedBox(),
            ),
            Obx(() => _environmentNewsController.showBigCard.value
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
