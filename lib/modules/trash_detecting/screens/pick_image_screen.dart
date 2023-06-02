import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/models/trash.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/home/home_controller.dart';
import 'package:sowaste/modules/trash_detecting/screens/trash_decteting_screen.dart';
import 'package:sowaste/modules/trash_detecting/trash_detecting_controller.dart';

import '../widgets/pick_image.dart';

class PickImageScreen extends StatelessWidget {
  PickImageScreen({super.key});
  final TrashDetectingController _trashDetectingController =
      Get.put(TrashDetectingController());
  final DictionaryController _dictionaryController = Get.find();
  final HomeController _homeController = Get.find();
  List<Widget> stackChildren = [];

  Future<void> uploadImage() async {
    try {
      var uri = Uri.parse(UrlValue.detectTrashUrl);
      var request = http.MultipartRequest("POST", uri);
      request.files.add(await http.MultipartFile.fromPath(
        'img_file', // NOTE - this value must match the 'file=' at the start of -F
        ImageServices.pickedImage!.path,
        contentType: MediaType('image', 'png'),
      ));
      final response = await http.Response.fromStream(await request.send());
      final temp = await json.decode(response.body);
      _trashDetectingController.recognitions.value = temp["model_predict"];
      _trashDetectingController.imgWidth = temp["width"];
      _trashDetectingController.imgHeight = temp["height"];
    } catch (error) {}
  }

  Future<void> pickImageToDetect({bool camera = true}) async {
    _trashDetectingController.setDetectedTrash.value = [];
    try {
      ImageServices.pickedImage == null;
      _trashDetectingController.recognitions.value = [];
      _trashDetectingController.isLoading.value = true;
      camera == true
          ? await ImageServices.getImageFromCamera()
          : await ImageServices.getImageFromGallery();
      if (ImageServices.pickedImage != null) {
        Get.to(() => TrashDetectingScreen());
      }
      await uploadImage();
      // Post recent Trash
      ++DataCenter.timesDeteted.value;

      Set<dynamic> set = _trashDetectingController.recognitions.map((trash) {
        return trash["class"];
      }).toSet();

      print(set.length);

      for (var name in set) {
        try {
          Trash? t = await _trashDetectingController.getDetectedTrash(name);
          if (t != null) _trashDetectingController.setDetectedTrash.add(t);

          // chart
          _dictionaryController.currentTrash.value = t!;
          _homeController.indexHasColor.value =
              DataCenter.recentDetectedTrashes.length;
          await _dictionaryController.postRecentTrashToLocalStorage(
              isDetected: true);

          _homeController.updateTotalDetectedObjects();
          _homeController
              .setColorForPieChart(_homeController.indexHasColor.value);
        } catch (error) {
          log(error.toString());
        }
      }
    } catch (error) {
      log(error.toString());
    } finally {
      _trashDetectingController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ArrowBackAppBar(
          title: "Detect Waste ",
          isShowArrowBackIcon: false,
        ),
        body: Container(
          color: AppColors.primary.withOpacity(0.1),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16)),
                height: 220,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select Image From ",
                        style: CustomTextStyle.sub(AppColors.onBg),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => {pickImageToDetect()},
                            child: const PickImageButton(
                                img: AppImages.camera, text: "Camera"),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          GestureDetector(
                            onTap: () => {pickImageToDetect(camera: false)},
                            child: const PickImageButton(
                                img: AppImages.gallery, text: "Gallery"),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
