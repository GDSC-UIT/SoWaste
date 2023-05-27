import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class Avatar extends StatelessWidget {
  String title;
  String image;
  Avatar({super.key, this.title = '', this.image = ''});

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
        Text(
          (title == '' ? 'User' : title),
          style: CustomTextStyle.sub(AppColors.primary),
        ),
      ],
    );
  }
}
