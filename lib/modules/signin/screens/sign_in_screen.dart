import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/global_widget/app_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  Widget signInWithGoogleButton(
      VoidCallback onPressedFunction, BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
            side: const BorderSide(width: 1, color: AppColors.primary),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: onPressedFunction,
        child: SizedBox(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.googleIcon,
                  height: 30,
                ),
                Expanded(
                  child: Text("SIGN IN WITH GOOGLE",
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.button(Colors.black)),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: CustomTextStyle.h3(Colors.black),
                    ),
                    Text(
                      'Start sorting smarter, not harder with SoWaste',
                      style: CustomTextStyle.h3(AppColors.primary)
                          .copyWith(height: 1.2),
                    )
                  ]),
            ),
            Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.camera,
                    height: 300,
                  ),
                )),
            SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [signInWithGoogleButton(() {}, context)],
                ))
          ],
        ),
      ),
    );
  }
}
