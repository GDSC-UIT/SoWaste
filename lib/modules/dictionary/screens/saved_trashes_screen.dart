import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/app_card_button.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/screens/trash_detail_screen.dart';

import '../../../data/models/trash.dart';

class SavedTrashesScreen extends StatelessWidget {
  SavedTrashesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final DictionaryController _dictionaryController = Get.find();

    return Scaffold(
        appBar: const ArrowBackAppBar(
          title: "Saved types of trash",
        ),
        body: Obx(() => ListView.builder(
              itemBuilder: (context, index) => AppCardButton(
                  onTapFunction: () async {
                    _dictionaryController
                        .getDetailTrash(DataCenter.dictionary[index].id);
                  },
                  title: DataCenter.savedTrashList[index]["name"]),
              itemCount: DataCenter.savedTrashList.length,
            )));
  }
}
