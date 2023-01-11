import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt count = 0.obs;
  void increase() {
    ++count.value;
  }
}
