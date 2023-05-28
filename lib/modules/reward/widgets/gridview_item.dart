import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/modules/reward/widgets/mall_item.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 14,
          //mainAxisSpacing: 20,
          childAspectRatio: 0.65,
        ),
        itemCount: 12,
        itemBuilder: (context, index) =>
            MallItem(point: 0, image: AppImages.trophy));
  }
}
