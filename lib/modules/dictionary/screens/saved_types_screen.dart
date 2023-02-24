import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/global_widget/app_card_button.dart';

class SavedTypesScreen extends StatelessWidget {
  const SavedTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Saved types of trash",
            style: CustomTextStyle.sub(AppColors.primary),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => AppCardButton(
              onTapFunction: () {
                print("Clicked on Card!");
              },
              title: "Plastic"),
          itemCount: 10,
        ));
  }
}
