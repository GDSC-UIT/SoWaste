import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/global_widget/search_input.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';

class SearchTrash extends StatelessWidget {
  SearchTrash({super.key});
  final DictionaryController _dictionaryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSearchInput(
            onChangeFunction: (String value) => {
                  _dictionaryController
                      .filterWord(_dictionaryController.searchInput.value.text)
                },
            deleteInput: () {
              _dictionaryController.searchInput.text = '';
              _dictionaryController.filterWord('');
            },
            controller: _dictionaryController.searchInput),
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child:
                            Text(_dictionaryController.foundWords[index].name),
                      ),
                      onTap: () => {
                        _dictionaryController.getDetailTrash(
                            _dictionaryController.foundWords[index].id)
                      },
                    ),
                    const Divider(
                      thickness: 0.3,
                    )
                  ],
                ),
              ),
              itemCount: _dictionaryController.foundWords.length,
            ),
          ),
        )
      ],
    );
  }
}
