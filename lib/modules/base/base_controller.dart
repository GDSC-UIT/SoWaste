import 'package:get/get.dart';
import 'package:sowaste/modules/env_news/screens/env_news_screen.dart';
import 'package:sowaste/modules/home/screens/home_screen.dart';

class BaseController extends GetxController {
  var currentIndex = 0.obs;

  var pages = [
    HomeScreen(),
    const EnvNewsScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ].obs;
}
