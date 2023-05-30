import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/widgets/diy_card.dart';

class ListDIY extends StatelessWidget {
  ListDIY({super.key});
  final DictionaryController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: ((context, index) => DIYCard(
              onTap: () async {
                await _controller.getDIYDetails(_controller.diyList[index].id);
              },
              title: _controller.diyList[index].title,
              image: _controller.diyList[index].displayImage,
            )),
        separatorBuilder: (context, index) => SizedBox(
              height: 16,
            ),
        itemCount: _controller.diyList.length);
    ;
  }
}
