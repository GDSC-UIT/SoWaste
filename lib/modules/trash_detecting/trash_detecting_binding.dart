import 'package:get/get.dart';
import 'package:sowaste/modules/trash_detecting/trash_detecting_controller.dart';

class TrashDetectingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrashDetectingController>(() => TrashDetectingController());
  }
}
