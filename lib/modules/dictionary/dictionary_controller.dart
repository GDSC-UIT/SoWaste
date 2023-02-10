import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController {
  final List<String> allWords = [
    "Plastic",
    "Glass",
    "Metal",
  ];
  TextEditingController searchInput = TextEditingController();
  Rx<List<String>> foundWords = Rx<List<String>>([]);
  @override
  void onInit() {
    foundWords.value = [];
    // TODO: implement onInit
    super.onInit();
  }

  void filterWord(String word) {
    List<String> result = [];
    if (word.isNotEmpty) {
      result = allWords
          .where(
              (e) => e.toLowerCase().contains(searchInput.text.toLowerCase()))
          .toList();
    }
    foundWords.value = result;
  }
}
