import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/core/themes/app_colors.dart';

class OptionCard extends StatelessWidget {
  OptionCard(
      {super.key,
      required this.answer,
      this.isRightAnswer,
      required this.isAble});
  final String answer;
  bool? isRightAnswer;
  bool isAble;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isAble,
      child: InkWell(
          onTap: () {
            print("Clicked to choose!");
          },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: isRightAnswer == null
                  ? Border.all(color: AppColors.info, width: 1)
                  : null,
              color: isRightAnswer != null
                  ? (isRightAnswer == true
                      ? AppColors.primaryDark
                      : AppColors.error)
                  : AppColors.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(child: Text(answer)),
            ),
          )),
    );
  }
}
