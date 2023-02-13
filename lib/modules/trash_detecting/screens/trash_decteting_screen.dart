import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/data/services/image_picker_services.dart';
import 'package:sowaste/modules/trash_detecting/widgets/trash_button.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';

class TrashDetectingScreen extends StatelessWidget {
  TrashDetectingScreen({super.key});

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
            constraints: BoxConstraints(maxHeight: 80 * 3),
            child: ListView.builder(
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TrashButton(),
                    )),
                itemCount: 3),
          )
        ],
      ),
    );
  }
}
