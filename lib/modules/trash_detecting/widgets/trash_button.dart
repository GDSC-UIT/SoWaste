import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

import '../../../data/models/trash.dart';

class TrashButton extends StatefulWidget {
  const TrashButton({super.key, required this.trash});
  final Trash? trash;

  @override
  State<TrashButton> createState() => _TrashButtonState();
}

class _TrashButtonState extends State<TrashButton> {
  bool isShowedDetail = false;
  final DictionaryController _dictionaryController =
      Get.put(DictionaryController());
  @override
  Widget build(BuildContext context) {
    if (widget.trash == null) return Container();
    String typeOfTrash = (widget.trash!.isOrganic ? "Organic" : "") +
        (widget.trash!.isRecyable ? "Recyable" : "");

    return GestureDetector(
        onTap: () {
          setState(() {
            isShowedDetail = !isShowedDetail;
          });
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.onBg.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.trash!.name,
                  style: CustomTextStyle.title(
                       isShowedDetail ? AppColors.primary : AppColors.onBg),
                ),
                isShowedDetail
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            typeOfTrash,
                            style: CustomTextStyle.normal(AppColors.onBg)
                                .copyWith(height: 1.5),
                          ),
                          Text(
                            widget.trash!.shortDescription,
                            style: CustomTextStyle.normal(AppColors.info)
                                .copyWith(height: 1.2),
                            maxLines: 2,
                          ),
                          GestureDetector(
                              onTap: () {
                                _dictionaryController
                                    .getDetailTrash(widget.trash!.id);
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
