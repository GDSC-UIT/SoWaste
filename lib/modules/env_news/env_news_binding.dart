import 'package:get/get.dart';
import 'package:sowaste/modules/env_news/env_news_controller.dart';

class EnvironmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnvironmentNewsController>(() => EnvironmentNewsController());
  }
}
