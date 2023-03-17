import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

import '../../../data/models/trash.dart';

class DictionaryCard extends StatelessWidget {
  DictionaryCard({
    super.key,
  });

  final _index = Random().nextInt(DataCenter.dictionary.length);

  @override
  Widget build(BuildContext context) {
    final Trash trash = DataCenter.dictionary[_index];
    final DictionaryController dictionaryController = Get.find();
    return SizedBox(
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 5,
        shadowColor: AppColors.onBg.withOpacity(0.7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: GridTile(
            footer: Container(
              decoration: BoxDecoration(
                color: AppColors.background.withOpacity(0.6),
              ),
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trash.name,
                          style: CustomTextStyle.bodyBold(AppColors.onSur),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          trash.isOrganic ? "Organic" : "",
                          style: CustomTextStyle.medium(AppColors.onBg),
                        ),
                        Text(
                          trash.shortDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: CustomTextStyle.normal(AppColors.onBg),
                        ),
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                              ),
                              onPressed: () => {
                                    dictionaryController
                                        .getDetailTrash(trash.id)
                                  },
                              child: Row(
                                children: const [
                                  Text("Read more"),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              )),
                        )
                      ]),
                ),
              ),
            ),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/images/placeholder.png'),
              image: NetworkImage(trash.displayImage),
            ),
          ),
        ),
      ),
    );
  }
}
