import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class ProfileSelection extends StatelessWidget {
  Function? onTap;
  String title;
  IconData icon;
  ProfileSelection({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        onTap;
      },
      child: Container(
        width: screenWidth * (390 / 428),
        height: 72,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: 23.5,
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                  color: AppColors.primaryDark),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 15.5,
            ),
            Text(
              title,
              style: CustomTextStyle.bodyBold(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
