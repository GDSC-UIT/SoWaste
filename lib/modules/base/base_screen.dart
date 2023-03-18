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
      appBar: null,
      body: Obx(() => IndexedStack(
            index: BaseController.currentIndex.value,
            children: _baseController.pages,
          )),
      bottomNavigationBar: const BottomNavBar(),
    ));
  }
}
