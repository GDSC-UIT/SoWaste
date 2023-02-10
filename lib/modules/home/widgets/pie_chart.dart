import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/home/home_controller.dart';
import 'package:d_chart/d_chart.dart';

class PieChart extends StatelessWidget {
  PieChart({super.key});
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    _homeController.setColorForPieChart(_homeController.indexHasColor.value);
    List<Map<String, dynamic>> data = [..._homeController.dummy_data];
    return SizedBox(
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: min(200, _homeController.colors.length * 30),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  final e = data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: _homeController.colors
                                  .elementAt(data.indexOf(e)),
                              borderRadius: BorderRadius.circular(4)),
                          width: 32,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          e['category'],
                          style: CustomTextStyle.normal(Color(0xFF747474)),
                        )
                      ],
                    ),
                  );
                })),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: DChartPie(
                  labelFontSize: 12,
                  showLabelLine: true,
                  labelColor: AppColors.onBg,
                  labelPosition: PieLabelPosition.outside,
                  labelLinelength: 6,
                  pieLabel: (pieData, index) => '${pieData['measure']}%',
                  fillColor: (pieData, index) =>
                      _homeController.colors.elementAt(index!),
                  data: data
                      .map((e) => {
                            'domain': e['category'],
                            'measure':
                                (e['times'] / _homeController.count.value * 100)
                          })
                      .toList()),
            ),
          )
        ],
      ),
    );
  }
}
