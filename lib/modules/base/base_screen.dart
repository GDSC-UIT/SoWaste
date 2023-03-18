import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/modules/base/base_controller.dart';

import '../../global_widget/bottom_navbar.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});
  final BaseController _baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(() {
        return _baseController.pages[_baseController.currentIndex.value];
      }),
      bottomNavigationBar: BottomNavBar(),
    ));
  }
}
