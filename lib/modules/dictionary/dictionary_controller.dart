import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/services/data_center.dart';

import '../../data/models/trash.dart';

class DictionaryController extends GetxController {
  TextEditingController searchInput = TextEditingController();
  Rx<List<Trash>> foundWords = Rx<List<Trash>>([]);
  @override
  void onInit() {
    foundWords.value = [];
    super.onInit();
  }

  void filterWord(String word) {
    List<Trash> result = [];
    if (word.isNotEmpty) {
      result = DataCenter.dictionary
          .where((e) =>
              e.name.toLowerCase().contains(searchInput.text.toLowerCase()))
          .toList();
    }
    foundWords.value = result;
  }
}
