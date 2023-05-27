import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';

class EmptyBag extends StatelessWidget {
  const EmptyBag({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * (112 / 926),
      width: screenWidth * (182 / 428),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset(AppImages.emptybag),
      ),
    );
  }
}
