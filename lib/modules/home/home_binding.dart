import 'package:get/get.dart';
import 'package:sowaste/modules/home/view_models/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
