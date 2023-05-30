import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/models/trash.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/app_card_button.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/widgets/categories_card.dart';
import 'package:sowaste/modules/dictionary/widgets/empty.dart';

class SavedTrashesScreen extends StatelessWidget {
  SavedTrashesScreen({super.key});
  final DictionaryController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ArrowBackAppBar(
          title: "Saved types of waste",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => _controller.savedTrashList.isEmpty
              ? const Empty(text: "saved any waste yet!")
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
                  itemBuilder: (context, index) {
                    Trash t = _controller.savedTrashList[index];
                    return CategoriesCard(
                        title: t.name,
                        image: t.displayImage,
                        onPress: () => {_controller.getDetailTrash(t.id)});
                  },
                  itemCount: _controller.savedTrashList.length,
                )),
        ));
  }
}
