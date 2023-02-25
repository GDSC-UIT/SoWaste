import 'package:get/get.dart';
import 'package:sowaste/modules/map/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(() => MapController());
  }
}
