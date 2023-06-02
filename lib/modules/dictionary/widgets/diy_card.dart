import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/image_picker_services.dart';

class DIYCard extends StatelessWidget {
  String title;
  String image;
  void Function()? onTap;
  DIYCard({super.key, required this.title, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Stack(children: [
        Container(
          height: screenHeight * (232 / 932),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(image), fit: BoxFit.contain),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Container(
            width: screenWidth,
            height: screenHeight * (232 / 932),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(0, 203, 93, 0),
                Color.fromRGBO(0, 161, 74, 1),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Column(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Text(
                    title,
                    style: CustomTextStyle.DIYtitle(),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            )),
      ]),
    );
  }
}
