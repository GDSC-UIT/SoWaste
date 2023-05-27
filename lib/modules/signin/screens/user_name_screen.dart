import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/modules/signin/sign_in_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

class UserNameScreen extends StatelessWidget {
  UserNameScreen({super.key});
  final SignInController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "...Can I ask your name?",
                    style: CustomTextStyle.h3(Colors.black),
                  ),
                  Text(
                    'Enter the name you would like to go by',
                    style: CustomTextStyle.large(Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _controller.name,
                            style: CustomTextStyle.h2(Colors.black)
                                .copyWith(height: 1),
                            decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: 'NAME',
                                hintStyle: CustomTextStyle.h2(
                                    AppColors.info) // Set the hint text
                                ),
                          ),
                        ),
                        Container(
                          height: 40,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            label: const Text(''),
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.info,
                            ),
                            onPressed: () {
                              Get.toNamed(AppRoutes.signInPage);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.welcome,
                    height: 300,
                  ),
                )),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
