import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';

import '../trash_detecting_controller.dart';
import '../widgets/trash_button.dart';

class TrashDetectingScreen extends StatelessWidget {
  TrashDetectingScreen({super.key});
  final TrashDetectingController _trashDetectingController = Get.find();
  List<Widget> stackChildren = [];

  List<Widget> renderBoxes(Size size) {
    final ratio = size.width / _trashDetectingController.imgWidth;
    // print("Ratio: $ratio");
    stackChildren.add(Image.file(ImageServices.pickedImage!));

    // print(_trashDetectingController.recognitions);
    if (_trashDetectingController.recognitions.isEmpty) return [];

    return _trashDetectingController.recognitions.map((re) {
      return Positioned(
        left: re["xmin"] * ratio,
        top: re["ymin"] * ratio,
        width: (re["xmax"] - re["xmin"]) * ratio,
        height: (re["ymax"] - re["ymin"]) * ratio,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.yellow,
            width: 3,
          )),
          child: Text(
            "${re["name"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = Colors.yellow,
              color: AppColors.onBg,
              fontSize: 12,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ArrowBackAppBar(
          title: "Detect Trash",
          onTap: () {
            Get.back();
          },
        ),
        body: Obx(() {
          final size = MediaQuery.of(context).size;
          stackChildren.addAll(renderBoxes(size));
          return _trashDetectingController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView(children: [
                  Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: stackChildren),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: SizedBox(
                          child: _trashDetectingController
                                  .recognitions.isNotEmpty
                              ? Column(
                                  children: _trashDetectingController
                                      .recognitions
                                      .map((trash) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: TrashButton(
                                                trash: _trashDetectingController
                                                    .getDetectedTrash(
                                                        trash["name"])),
                                          ))
                                      .toList())
                              : Container()))
                ]);
        }));
  }
}
