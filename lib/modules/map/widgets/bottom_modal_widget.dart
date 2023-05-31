import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

Future<String?> showBottomModal(context) {
  return showModalBottomSheet<String>(
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return FilterMapWidget();
      });
}

class FilterMapWidget extends StatelessWidget {
  FilterMapWidget({super.key});
  final DictionaryController _controller = Get.find();
  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(
        height: 8,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        navigator?.pop("Cancel");
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: AppColors.error,
                      )),
                  Text("Filter", style: CustomTextStyle.h4(Colors.black)),
                  TextButton(
                      onPressed: () {
                        navigator?.pop();
                      },
                      child: const Icon(
                        Icons.check,
                        color: AppColors.primary,
                      )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text("Recyclable materials",
                  style: CustomTextStyle.h4(AppColors.primary)),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: ((context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      (navigator?.context.width ?? 300) - 100,
                                  child: Text(
                                    _controller.allTrash[index].name,
                                    style:
                                        CustomTextStyle.bodyBold(Colors.black),
                                  ),
                                )
                              ],
                            ),
                            Obx(() => Checkbox(
                                  activeColor: AppColors.primary,
                                  splashRadius: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  value: _controller.selectedTrash.contains(
                                      _controller.allTrash[index].name),
                                  onChanged: (value) {
                                    if (value == true) {
                                      _controller.selectedTrash.add(
                                          _controller.allTrash[index].name);
                                    } else {
                                      _controller.selectedTrash.remove(
                                          _controller.allTrash[index].name);
                                    }
                                    _controller.selectedTrash.value = [
                                      ..._controller.selectedTrash
                                    ];
                                  },
                                )),
                          ],
                        );
                      }),
                      separatorBuilder: separatorBuilder,
                      itemCount: _controller.allTrash.length)),
            ],
          )),
    );
  }
}
