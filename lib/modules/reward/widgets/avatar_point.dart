import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';

class AvatarPoint extends StatelessWidget {
  String image;
  int point;
  AvatarPoint({super.key, this.image = '', this.point = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180),
            color: Colors.grey,
            image: DecorationImage(image: NetworkImage(image)),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 21, height: 30, child: Image.asset(AppImages.trophy)),
            SizedBox(
              width: 8,
            ),
            Text(
              "$point",
              style: CustomTextStyle.sub(AppColors.primary),
            ),
          ],
        )
      ],
    );
  }
}
