import 'package:get/get.dart';
import 'package:sowaste/modules/dictionary/screens/dictionary_overview_screen.dart';
import 'package:sowaste/modules/env_news/screens/env_news_search_screen.dart';
import 'package:sowaste/modules/home/screens/home_screen.dart';

class BaseController extends GetxController {
  var currentIndex = 0.obs;

  var pages = [
    HomeScreen(),
    EnvironmentNewsOverviewScreen(),
    EnvironmentNewsOverviewScreen(),
    const DictionaryOverviewScreen(),
    HomeScreen(),
  ].obs;
}
