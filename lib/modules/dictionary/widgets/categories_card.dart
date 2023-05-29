import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class CategoriesCard extends StatelessWidget {
  String title;
  String image;
  CategoriesCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        height: screenHeight * (88 / 932),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            const SizedBox(
              width: 13,
            ),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  color: AppColors.imageCategories,
                  borderRadius: BorderRadius.circular(180),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fill)),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: CustomTextStyle.Categoriestitle(),
                softWrap: true,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
            const SizedBox(
              width: 21,
            )
          ],
        ));
  }
}