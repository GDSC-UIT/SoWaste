import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';

class RowTitle extends StatelessWidget {
  const RowTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Exchange",
          style: CustomTextStyle.subHeading(Colors.black),
        ),
        SizedBox(
          width: 6,
        ),
        Container(
          height: 24,
          width: 15.5,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(AppImages.trophy),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          "to real rewards",
          style: CustomTextStyle.subHeading(Colors.black),
        ),
      ],
    );
  }
}
