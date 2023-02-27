import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_file_path.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/dictionary/screens/quizzes.dart';
import 'package:sowaste/modules/dictionary/widgets/search_input.dart';
import 'package:sowaste/routes/app_routes.dart';

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
            style: CustomTextStyle.sub(AppColors.secondary),
          ),
        ),
        body: Stack(children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(
                height: 55,
              ),
              gap(),
              Text(
                "Type of trash of the day",
                style: CustomTextStyle.bodyBold(AppColors.secondary),
              ),
              gap(),
              DictionaryCard(),
              AppCardButton(
                onTapFunction: () {
                  Get.to(() => QuizzesScreen());
                },
                title: "Quiz time",
                leading: const Icon(
                  Icons.import_contacts,
                  color: AppColors.primary,
                ),
              ),
              AppCardButton(
                onTapFunction: () {
                  Get.toNamed(AppRoutes.savedTypesPage);
                },
                title: "Saved types of trash",
                leading: const Icon(
                  Icons.bookmark_outline,
                  color: AppColors.primary,
                ),
              ),
              AppCardButton(
                onTapFunction: () async {
                  await LocalService.clearContent(AppFilePath.recentTrashes);
                  Get.toNamed(AppRoutes.recentTypesPage);
                },
                title: "Recent types of trash ",
                leading: const Icon(
                  Icons.update_rounded,
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
