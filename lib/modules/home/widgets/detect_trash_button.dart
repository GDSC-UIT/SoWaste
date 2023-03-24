import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/base/base_controller.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
          onTap: () async {
            BaseController.changeIndexPage(2);
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
