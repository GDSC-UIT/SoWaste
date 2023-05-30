import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/models/diy.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/global_widget/markdown_text.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

class DIYDetailScreen extends StatelessWidget {
  DIYDetailScreen({super.key});
  final DictionaryController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const ArrowBackAppBar(
              isShowArrowBackIcon: true,
            ),
            body: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final DIY diy = _controller.currentDIY.value!;
                return ListView(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 8),
                  children: [
                    SizedBox(
                      height: context.height * 0.2,
                      width: double.infinity,
                      child: Image.network(
                        diy.displayImage,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      diy.title,
                      style: CustomTextStyle.sub(AppColors.onBg),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Posted ${GetTimeAgo.parse(diy.createAt)}",
                      style: CustomTextStyle.normal(AppColors.onBg),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      diy.shortDescription,
                      style: CustomTextStyle.bodyBold(AppColors.onBg),
                    ),
                    const SizedBox(height: 16),
                    MarkdownText(
                      text: diy.description!,
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                );
              }
            })));
  }
}
