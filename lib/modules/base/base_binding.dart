import 'package:get/get.dart';
import 'package:sowaste/modules/base/base_controller.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';
import 'package:sowaste/modules/home/home_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(() => BaseController());
    Get.put<HomeController>(HomeController());
    Get.lazyPut<EnvironmentNewsController>(() => EnvironmentNewsController());
    Get.lazyPut<DictionaryController>(() => DictionaryController());
  }
}
