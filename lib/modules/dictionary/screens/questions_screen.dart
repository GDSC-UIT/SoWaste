import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/dictionary/widgets/option_button.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({super.key});
  int point = 0;
  int questionNumber = 1;
  String question =
      'Jorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.';
  List<String> options = [
    'Choice',
    'Choice',
    'Choice',
    'Choice',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Quiz: Plastic Bottle",
          style: CustomTextStyle.sub(AppColors.primary),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        children: [
          Text(
            "Point: $point",
            style: CustomTextStyle.title(AppColors.secondary),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Question $questionNumber",
            style: CustomTextStyle.sub(AppColors.onBg),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            question,
            style: CustomTextStyle.large(AppColors.onBg),
          ),
          const SizedBox(
            height: 24,
          ),
          Column(
            children: options
                .map((e) => OptionButton(answer: e, isAble: true))
                .toList(),
          )
        ],
      ),
    );
  }
}
