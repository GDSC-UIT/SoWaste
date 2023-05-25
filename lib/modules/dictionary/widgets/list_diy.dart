import 'package:flutter/material.dart';
import 'package:sowaste/modules/dictionary/widgets/diy_card.dart';

class ListDIY extends StatelessWidget {
  const ListDIY({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: ((context, index) => DIYCard(
              title: "How to make Paper Basket | Do It Yourself",
              image:
                  "https://images.pexels.com/photos/1108572/pexels-photo-1108572.jpeg?auto=compress&cs=tinysrgb&w=600",
            )),
        separatorBuilder: (context, index) => SizedBox(
              height: 16,
            ),
        itemCount: 10);
    ;
  }
}
