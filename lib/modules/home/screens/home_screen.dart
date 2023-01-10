import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/modules/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Obx(() => Text('Home Screen ${_homeController.count}'))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _homeController.increase();
        },
      ),
    );
  }
}
