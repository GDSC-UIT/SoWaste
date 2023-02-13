import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class TrashButton extends StatefulWidget {
  const TrashButton({super.key});

  @override
  State<TrashButton> createState() => _TrashButtonState();
}

class _TrashButtonState extends State<TrashButton> {
  bool isShowedDetail = false;
  int index = 0;
  Map<String, String> data = {
    "name": "Metal bin",
    "type": "Metal",
    "category": "Recycling Trash",
    "description":
        "A metal bin is a container made of metal, typically used for storing and transporting waste or other materials...",
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isShowedDetail = !isShowedDetail;
          });
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.background.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "($index) ${data["name"]}",
                  style: CustomTextStyle.title(
                      isShowedDetail ? AppColors.primary : AppColors.onBg),
                ),
                isShowedDetail
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trash type: ${data["type"]}",
                            style: CustomTextStyle.normal(AppColors.onBg)
                                .copyWith(height: 1.5),
                          ),
                          Text(
                            '${data["category"]}',
                            style: CustomTextStyle.normal(AppColors.secondary)
                                .copyWith(height: 1.8),
                          ),
                          Text(
                            "${data["description"]}",
                            style: CustomTextStyle.normal(AppColors.info)
                                .copyWith(height: 1.2),
                            maxLines: 2,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed('/detail');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'See more in dictionary',
                                      style: CustomTextStyle.normal(
                                          AppColors.primaryDark),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.primaryDark,
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )
                    : Container()
              ],
            )));
  }
}
