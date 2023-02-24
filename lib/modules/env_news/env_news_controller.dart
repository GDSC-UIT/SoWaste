import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/services/data_center.dart';

class EnvironmentNewsController extends GetxController {
  Rx<TextEditingController> searchInput = TextEditingController(text: "").obs;
  RxList<Article> news = <Article>[].obs;
  @override
  void onInit() {
    news.value = [...DataCenter.news];
    super.onInit();
  }

  void filterArticle() {
    news.value = DataCenter.news
        .where((article) =>
            article.title.toLowerCase().contains(searchInput.value.text))
        .toList();
  }
}
