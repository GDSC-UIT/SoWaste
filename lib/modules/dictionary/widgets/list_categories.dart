import 'package:flutter/material.dart';
import 'package:sowaste/modules/dictionary/widgets/categories_card.dart';

class ListCategories extends StatelessWidget {
  const ListCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: ((context, index) => CategoriesCard(
                title: "plastic",
                image:
                    'https://img.lovepik.com/free-png/20211225/lovepik-bottle-icons-png-image_400323544_wh860.png',
              )),
          separatorBuilder: (context, index) => SizedBox(
                height: 8,
              ),
          itemCount: 10),
    );
  }
}
