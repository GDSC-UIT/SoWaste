import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/dictionary/screens/categories_diy_screen.dart';
import 'package:sowaste/modules/dictionary/screens/dictionary_overview_screen.dart';
import 'package:sowaste/modules/env_news/screens/env_news_search_screen.dart';
import 'package:sowaste/modules/home/screens/home_screen.dart';
import 'package:sowaste/modules/trash_detecting/screens/pick_image_screen.dart';
import 'package:sowaste/modules/map/screens/map_screen.dart';

class BaseController extends GetxController {
  static final RxInt currentIndex = 0.obs;
  static TabController? tabController;

  /// change page from index
  static void changeIndexPage(int index) {
    currentIndex.value = index;
    tabController!.animateTo(index);
  }

  @override
  var pages = [
    const HomeScreen(),
    //const DictionaryOverviewScreen(),
    const CategoriesandDIYscreen(),
    PickImageScreen(),
    const MapScreen(),
    EnvironmentNewsOverviewScreen(),
  ].obs;
}
