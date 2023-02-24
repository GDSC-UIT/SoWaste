import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/article.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/http_service.dart';

import '../../data/models/trash.dart';

class HomeController extends GetxController {
  bool hasError = false;
  RxBool isLoading = false.obs;

  var articlesList = <Article>[].obs;
  var dictionary = <Trash>[].obs;

  @override
  void onInit() async {
    fetchArticles();
    fetchDictionary();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final response = await HttpService.getRequest(UrlValue.articlesUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      temp.forEach((article) {
        articlesList.add(Article.fromJson(article));
      });
      DataCenter.news = [...articlesList];
    } catch (error) {
      print("Error when fetch articles $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDictionary() async {
    try {
      isLoading.value = true;
      final response = await HttpService.getRequest(UrlValue.dictionaryUrl);
      final temp = await json.decode(utf8.decode(response.bodyBytes))["data"];
      print("Dictionary: $temp");
      temp.forEach((trash) => {dictionary.add(Trash.fromJson(trash))});
      DataCenter.dictionary = [...dictionary];
    } catch (error) {
      print("Error in fetch dictionary: $error");
    } finally {
      isLoading.value = false;
    }
  }

  RxInt indexHasColor = 0.obs;
  RxInt count = 1.obs;

  List<Map<String, dynamic>> dummy_data = [
    {"category": "Food", "times": 1},
    {"category": "Paper", "times": 1},
    {"category": "Food Waste", "times": 2},
  ];

  Set<Color> colors = {};

  void setColorForPieChart(int index) {
    while (index != dummy_data.length) {
      colors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      index = colors.length;
      indexHasColor.value = index;
    }
  }
}
