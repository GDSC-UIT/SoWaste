import 'package:get/get.dart';

import '../../data/models/trash.dart';
import '../../data/services/data_center.dart';

class TrashDetectingController extends GetxController {
  RxList recognitions = [].obs;
  RxBool isLoading = false.obs;
  int imgWidth = 0;
  int imgHeight = 0;

  Trash? getDetectedTrash(String name) {
    for (var trash in DataCenter.dictionary) {
      String temp = name.toLowerCase().substring(0, name.length - 1);
      if (trash.name.toLowerCase().contains(temp)) {
        return trash;
      }
    }
    return null;
  }
}
