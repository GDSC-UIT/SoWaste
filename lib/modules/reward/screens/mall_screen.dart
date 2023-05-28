import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/reward/widgets/empty_bag.dart';
import 'package:sowaste/modules/reward/widgets/gridview_item.dart';
import 'package:sowaste/modules/reward/widgets/row_exchange.dart';

class MallScreen extends StatelessWidget {
  const MallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Your Bag",
            style: CustomTextStyle.subHeading(Colors.black),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "Show items to the recycling point to redeem real-life items",
            style: CustomTextStyle.button(Colors.black),
          ),
          SizedBox(
            height: 24,
          ),
          Center(child: EmptyBag()),
          SizedBox(
            height: 38,
          ),
          RowTitle(),
          Expanded(child: GridViewItem()),
        ]),
      ),
    );
  }
}
