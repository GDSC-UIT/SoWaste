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
        title: "Environment News",
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSearchInput(
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
              Obx(
                () => _environmentNewsController.showBigCard.value
                    ? const SizedBox(height: 24)
                    : const SizedBox(),
              ),
              Obx(() => _environmentNewsController.showBigCard.value
                  ? CardBigNews(
                      article: DataCenter.news[DataCenter.news.length - 1])
                  : Container()),
              const SizedBox(height: 24),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: _environmentNewsController.news
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: NewsItem(article: e),
                            ))
                        .toList(),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
