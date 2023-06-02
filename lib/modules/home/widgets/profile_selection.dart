import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class ProfileSelection extends StatelessWidget {
  void Function()? onTap;
  String title;
  IconData icon;
  Color color;
  ProfileSelection({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * (390 / 428),
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Màu shadow và độ mờ
              spreadRadius: 1, // Kích thước của shadow
              blurRadius: 3, // Độ mờ của shadow
              offset: Offset(0, 2), // Vị trí của shadow
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 23.5,
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180), color: color),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
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
