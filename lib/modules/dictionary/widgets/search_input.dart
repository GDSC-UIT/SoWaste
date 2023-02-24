import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/routes/app_routes.dart';

class SearchInput extends StatelessWidget {
  SearchInput({super.key});
  final DictionaryController _dictionaryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 5,
            shadowColor: AppColors.onBg.withOpacity(0.3),
            child: TextField(
              controller: _dictionaryController.searchInput,
              onChanged: ((value) => _dictionaryController
                  .filterWord(_dictionaryController.searchInput.value.text)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16)),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                hintText: 'Search type of trash',
                hintStyle: CustomTextStyle.normal(AppColors.info),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 24,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 24,
                  ),
                  onPressed: () {
                    _dictionaryController.searchInput.text = '';
                    _dictionaryController.filterWord('');
                  },
                ),
                border: InputBorder.none,
              ),
            )),
        Container(
          constraints: const BoxConstraints(maxHeight: 250),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal,
                    offset: const Offset(0, 10),
                    color: AppColors.onBg.withOpacity(0.3)),
              ]),
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Text(
                          _dictionaryController.foundWords.value[index].name),
                      onTap: () => {
                        Get.toNamed(AppRoutes.detailPage,
                            arguments:
                                _dictionaryController.foundWords.value[index])
                      },
                    ),
                    const Divider(
                      thickness: 0.3,
                    )
                  ],
                ),
              ),
              itemCount: _dictionaryController.foundWords.value.length,
            ),
          ),
        )
      ],
    );
  }
}
