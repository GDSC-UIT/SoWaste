import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/modules/home/home_controller.dart';

class CameraButton extends StatelessWidget {
  CameraButton({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
          onTap: () async {
            _homeController.count.value += 1;
            await ImageServices.getImageFromCamera();
            Get.toNamed('/detect');
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.primary),
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt,
                  size: 56,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Start detecting trash",
                  style: CustomTextStyle.bodyBold(Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
