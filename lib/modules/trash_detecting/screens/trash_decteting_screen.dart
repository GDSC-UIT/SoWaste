import 'package:flutter/material.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/modules/trash_detecting/widgets/trash_button.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

class TrashDetectingScreen extends StatelessWidget {
  const TrashDetectingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trash Detecting Camera",
          style: CustomTextStyle.sub(AppColors.primary),
        ),
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
