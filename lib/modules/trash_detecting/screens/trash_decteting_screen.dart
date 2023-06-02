import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/data/models/trash.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';

import '../trash_detecting_controller.dart';
import '../widgets/trash_button.dart';

class TrashDetectingScreen extends StatelessWidget {
  TrashDetectingScreen({super.key});
  final TrashDetectingController _trashDetectingController = Get.find();
  List<Widget> stackChildren = [];

  List<Widget> renderBoxes(Size size) {
    final double ratio = size.width / _trashDetectingController.imgWidth;
    stackChildren.add(Image.file(ImageServices.pickedImage!));

    if (_trashDetectingController.recognitions.isEmpty) return [];
    return _trashDetectingController.recognitions.map((re) {
      double left = double.parse(re["xmin"].toString()) * ratio;
      double top = double.parse(re["ymin"].toString()) * ratio;
      double width =
          (double.parse(re["xmax"]) - double.parse(re["xmin"])) * ratio;
      double height =
          (double.parse(re["ymax"]) - double.parse(re["ymin"])) * ratio;
      return Positioned(
        left: left,
        top: top,
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: AppColors.primaryLight,
            width: 3,
          )),
          child: Text(
            "${re["class"]} ${(double.parse(re["confidence"]) * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = AppColors.primaryLight,
              color: Colors.black,
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
          title: "Detect Waste",
          onTap: () {
            Get.back();
          },
        ),
        body: Obx(() {
          final size = MediaQuery.of(context).size;
          stackChildren.addAll(renderBoxes(size));
          return _trashDetectingController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Scrollbar(
                  thumbVisibility: true,
                  thickness: 8.0,
                  radius: const Radius.circular(10),
                  child: ListView(children: [
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
                                        .setDetectedTrash
                                        .map((trash) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: TrashButton(trash: trash));
                                  }).toList())
                                : Container()))
                  ]),
                );
        }));
  }
}
