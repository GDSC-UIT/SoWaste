import 'package:flutter/material.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/modules/dictionary/widgets/categories_card.dart';

class ListCategories extends StatelessWidget {
  const ListCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: ((context, index) => CategoriesCard(
                title: DataCenter.dictionary[index].name,
                image: DataCenter.dictionary[index].displayImage,
              )),
          separatorBuilder: (context, index) => SizedBox(
                height: 8,
              ),
          itemCount: 10),
    );
  }
}
