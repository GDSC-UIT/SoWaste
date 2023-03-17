import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/app_card_button.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/widgets/empty.dart';

class RecentTypesScreen extends StatelessWidget {
  const RecentTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DictionaryController dictionaryController = Get.find();
    return Scaffold(
        appBar: const ArrowBackAppBar(
          title: "Recent types of trash",
        ),
        body: Obx(() => DataCenter.recentTrashes.isEmpty
            ? const Empty(text: "searched or detectd any trash yet!")
            : ListView.builder(
                itemBuilder: (context, index) => AppCardButton(
                  onTapFunction: () {
                    dictionaryController
                        .getDetailTrash(DataCenter.recentTrashes[index]["id"]);
                  },
                  title: DataCenter.recentTrashes[index]["name"],
                ),
                itemCount: DataCenter.recentTrashes.length,
              )));
  }
}
