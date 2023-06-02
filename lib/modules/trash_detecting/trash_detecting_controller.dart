import 'package:get/get.dart';

import '../../data/models/trash.dart';
import '../../data/services/data_center.dart';

class TrashDetectingController extends GetxController {
  RxList recognitions = [].obs;
  RxList<Trash> setDetectedTrash = <Trash>[].obs;
  RxBool isLoading = false.obs;
  int imgWidth = 1;
  int imgHeight = 1;

  Future<Trash?> getDetectedTrash(String name) async {
    String temp = name.toLowerCase().substring(0, name.length);
    for (var trash in DataCenter.dictionary) {
      String trashName = trash.name.toLowerCase();
      if (temp.contains(trashName) ||
          (temp == "bottle" && trashName == "plastic bottle")) {
        return Trash.getTrash(trash.id);
      }
    }
    return null;
  }
}
