import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt indexHasColor = 0.obs;
  RxInt count = 0.obs;
  RxBool check = false.obs;

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
