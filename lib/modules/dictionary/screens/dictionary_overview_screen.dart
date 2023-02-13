import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/dictionary/widgets/search_input.dart';

import '../../../global_widget/app_card_button.dart';
import '../widgets/dictionary_card.dart';

class DictionaryOverviewScreen extends StatelessWidget {
  const DictionaryOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 1,
          title: Text(
            "Dictionary",
            style: CustomTextStyle.sub(AppColors.primary),
          ),
        ),
        body: Stack(children: [
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 55,
              ),
              gap(),
              Text(
                "Type of trash of the day",
                style: CustomTextStyle.bodyBold(AppColors.secondary),
              ),
              gap(),
              DictionaryCard(
                  imageUrl:
                      'https://1.bp.blogspot.com/-WKwzc-bXVpo/WR1SDIgSZ1I/AAAAAAAAAMg/siBVq8UdtD4IhLzpET2RRlj3Zgd2ZR-oQCLcB/s1600/n%25C6%25B0%25E1%25BB%259Bc%2Bkho%25C3%25A1ng.jpeg',
                  label: 'Plastic',
                  type: 'Recycleable',
                  description:
                      'There are different types of plastic that you need to know'),
              AppCardButton(
                onTapFunction: () {
                  print("Clicked!");
                },
                title: "Plastic Bottle",
                leading: const Icon(
                  Icons.save_as_rounded,
                  color: AppColors.primary,
                ),
              ),
              AppCardButton(
                onTapFunction: () {
                  print("Clicked!");
                },
                title: "Plastic Bottle",
                leading: const Icon(
                  Icons.save_as_rounded,
                  color: AppColors.primary,
                ),
              ),
              AppCardButton(
                onTapFunction: () {
                  print("Clicked!");
                },
                title: "Plastic Bottle",
                leading: const Icon(
                  Icons.save_as_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SearchInput(),
          ),
        ]));
  }
}

Widget gap() {
  return const SizedBox(
    height: 12,
  );
}
