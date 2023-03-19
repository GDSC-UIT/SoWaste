import 'package:flutter/material.dart';
import 'package:sowaste/core/values/app_constant.dart';

import '../core/themes/app_colors.dart';
import '../core/themes/app_themes.dart';

class AppSearchInput extends StatelessWidget {
  const AppSearchInput(
      {super.key,
      required this.onChangeFunction,
      required this.deleteInput,
      required this.controller});
  final Function onChangeFunction;
  final VoidCallback deleteInput;
  final TextEditingController controller;
  @override
  Card build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 7,
        shadowColor: AppConst.shadowColor,
        child: TextField(
          controller: controller,
          onChanged: ((value) => onChangeFunction(value)),
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
            border: InputBorder.none,
          ),
        ));
  }
}
