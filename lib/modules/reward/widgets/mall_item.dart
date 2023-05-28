import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';

class MallItem extends StatelessWidget {
  int point;
  String image;
  MallItem({super.key, required this.point, required this.image});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * (120 / 428),
      height: screenHeight * (167 / 926),
      child: Column(
        children: [
          Container(
            width: screenWidth * (120 / 428),
            height: screenHeight * (132 / 926),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primarySubtle),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Image.asset(image),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 15.5,
                height: 24,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(AppImages.trophy),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "$point",
                style: CustomTextStyle.title(AppColors.primary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
