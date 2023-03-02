import 'package:flutter/material.dart';

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
        elevation: 5,
        shadowColor: AppColors.onBg.withOpacity(0.3),
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
            // suffixIcon: IconButton(
            //   icon: const Icon(
            //     Icons.clear,
            //     size: 24,
            //   ),
            //   onPressed: deleteInput,
            // ),
            border: InputBorder.none,
          ),
        ));
  }
}
