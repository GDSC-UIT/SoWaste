import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class DIYCard extends StatelessWidget {
  String title;
  String image;
  DIYCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
        height: screenHeight * (232 / 932),
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      Container(
          // width: screenWidth * (388 / 482),
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
    ]);
  }
}
