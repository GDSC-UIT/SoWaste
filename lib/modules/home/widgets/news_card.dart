import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class NewsCard extends StatelessWidget {
  NewsCard({super.key, required this.imageUrl, required this.title});
  String imageUrl;
  String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("Clicked on news!");
        },
        child: SizedBox(
          width: 170,
          height: 200,
          child: Card(
              shadowColor: AppColors.onBg.withOpacity(0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(8),
              elevation: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                      width: 180,
                      child: Image(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: CustomTextStyle.link(AppColors.onBg),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
