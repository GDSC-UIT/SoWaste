import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/base/base_controller.dart';
import 'package:sowaste/modules/trash_detecting/widgets/trash_button.dart';

class TrashDetectingScreen extends StatelessWidget {
  const TrashDetectingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseController baseController = Get.find();
    return Scaffold(
      appBar: ArrowBackAppBar(
        title: "Detect Trash",
        onTap: () {
          Get.back();
        },
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image.file(ImageServices.pickedImage!),
          Container(
            constraints: const BoxConstraints(maxHeight: 80 * 3),
            child: ListView.builder(
                itemBuilder: ((context, index) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TrashButton(),
                    )),
                itemCount: 3),
          )
        ],
      ),
    );
  }
}
