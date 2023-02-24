import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/global_widget/markdown_text.dart';

import '../../../data/models/trash.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  final Trash _trash = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text(
            _trash.name,
            style: CustomTextStyle.h1(AppColors.primaryDark),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: MarkdownText(
              text: _trash.description,
            ),
          ),
        ],
      ),
    );
  }
}
