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
        styleSheet: MarkdownStyleSheet(
            h1: CustomTextStyle.sub(AppColors.onBg),
            h2: CustomTextStyle.title(AppColors.onBg),
            h3: CustomTextStyle.bodyBold(AppColors.onBg),
            h4: CustomTextStyle.h4(AppColors.onBg),
            p: CustomTextStyle.normal(AppColors.onBg),
            blockquoteDecoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.3),
            ),
            codeblockDecoration:
                BoxDecoration(color: AppColors.primaryLight.withOpacity(0.5))),
        imageBuilder: (uri, title, alt) {
          return Image.network(
            uri.toString(),
            frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) =>
                child),
            loadingBuilder: ((context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            }),
          );
        });
  }
}
