import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_themes.dart';
import '../../../global_widget/app_button.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});
  final int point = 80;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icons/laugh.png'),
              Column(
                children: [
                  Text(
                    'Congratulations!',
                    style: CustomTextStyle.h3(AppColors.onBg),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'You passed and got $point points ',
                    style: CustomTextStyle.bodyBold(AppColors.onBg),
                  ),
                ],
              ),
              AppButton(
                  buttonText: "CONTINUE",
                  onPressedFunction: () {
                    print("Try again");
                  }),
            ]),
      ),
    );
  }
}
