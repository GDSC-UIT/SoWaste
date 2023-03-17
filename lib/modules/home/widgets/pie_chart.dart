import 'dart:math';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/modules/home/home_controller.dart';

class PieChart extends StatelessWidget {
  PieChart({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: min(200, _homeController.colors.length * 30),
                child: ListView.builder(
                    itemCount: DataCenter.recentDetectedTrashes.length,
                    itemBuilder: ((context, index) {
                      final e = DataCenter.recentDetectedTrashes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: _homeController.colors.elementAt(
                                      DataCenter.recentDetectedTrashes
                                          .indexOf(e)),
                                  borderRadius: BorderRadius.circular(4)),
                              width: 32,
                              height: 16,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: 70,
                              child: Text(
                                e['name'],
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.normal(
                                    const Color(0xFF747474)),
                              ),
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
                      data: DataCenter.recentDetectedTrashes
                          .map((e) => {
                                'domain': e['name'],
                                'measure': ((e['count'] as int) /
                                        _homeController
                                            .totalDetectedObjects.value *
                                        100)
                                    .toInt()
                              })
                          .toList()),
                ),
              )
            ],
          ),
        ));
  }
}
