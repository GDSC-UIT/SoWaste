import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../core/themes/app_colors.dart';
import '../core/themes/app_themes.dart';

class MarkdownText extends StatelessWidget {
  const MarkdownText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      selectable: true,
      shrinkWrap: true,
      data: text,
      // onTapLink: (text, href, title) {
      //   href != null ? launch(href) : null;
      // },
      styleSheet: MarkdownStyleSheet(
          h1: CustomTextStyle.h1(AppColors.onBg),
          h2: CustomTextStyle.h2(AppColors.onBg),
          h3: CustomTextStyle.h3(AppColors.onBg),
          h4: CustomTextStyle.h4(AppColors.onBg),
          p: CustomTextStyle.normal(AppColors.onBg),
          blockquoteDecoration: BoxDecoration(
            color: AppColors.primaryLight.withOpacity(0.3),
          ),
          codeblockDecoration:
              BoxDecoration(color: AppColors.primaryLight.withOpacity(0.5))),
    );
  }
}
