import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/widgets/categories_card.dart';

class ListCategories extends StatelessWidget {
  ListCategories({super.key});
  final DictionaryController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
          itemBuilder: ((context, index) => CategoriesCard(
                title: _controller.foundTrash[index].name,
                image: _controller.foundTrash[index].displayImage,
                onPress: () => {
                  _controller.getDetailTrash(_controller.foundTrash[index].id)
                },
              )),
          separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
          itemCount: _controller.foundTrash.length),
    );
  }
}
