import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/modules/base/base_controller.dart';

import '../../global_widget/bottom_navbar.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseController = Get.put(BaseController());
    return SafeArea(
        child: Scaffold(
      body: Obx(() => baseController.pages[baseController.currentIndex.value]),
      bottomNavigationBar: const BottomNavBar(),
    ));
  }
}
