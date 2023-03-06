import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/trash_detecting/screens/trash_decteting_screen.dart';

class PickImageScreen extends StatelessWidget {
  const PickImageScreen({super.key});
  Widget PickImageButton({required String img, required String text}) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                img,
                height: 60,
                width: 60,
              ),
              Text(
                text,
                style: CustomTextStyle.normal(AppColors.onBg),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ArrowBackAppBar(
          title: "Detect Trash ",
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
                            onTap: () async {
                              await ImageServices.getImageFromCamera();
                              if (ImageServices.pickedImage != null) {
                                Get.to(() => const TrashDetectingScreen());
                              }
                            },
                            child: PickImageButton(
                                img: AppImages.camera, text: "Camera"),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await ImageServices.getImageFromGallery();
                              if (ImageServices.pickedImage != null) {
                                Get.to(() => const TrashDetectingScreen());
                              }
                            },
                            child: PickImageButton(
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
