import 'package:flutter/material.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/modules/dictionary/widgets/diy_card.dart';

class ListDIY extends StatelessWidget {
  const ListDIY({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: ((context, index) => DIYCard(
              title: DataCenter.dictionary[index].name,
              image: DataCenter.dictionary[index].displayImage,
            )),
        separatorBuilder: (context, index) => SizedBox(
              height: 16,
            ),
        itemCount: DataCenter.dictionary.length);
    ;
  }
}
