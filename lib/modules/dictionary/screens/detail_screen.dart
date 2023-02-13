import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  static const title = 'Test MarkDown';
  final String _markdownData = """
  # Minimal Markdown Test
  ---
  This is a simple Markdown test. Provide a text string with Markdown tags
  to the Markdown widget and it will display the formatted output in a
  scrollable widget.
  
  ## Section 1
  Maecenas eget **arcu egestas**, mollis ex vitae, posuere magna. Nunc eget
  aliquam tortor. Vestibulum porta sodales efficitur. Mauris interdum turpis
  eget est condimentum, vitae porttitor diam ~~ornare~~. [eclectify](www.eclectify.com)
  
  
  ### Subsection A
  *Sed et massa finibus*, blandit massa vel, vulputate velit. Vestibulum vitae
  venenatis libero. **__Curabitur sem lectus, feugiat eu justo in, eleifend
  accumsan ante.__** 
  > Sed a fermentum elit. Curabitur sodales metus id mi
  > ornare, in ullamcorper magna congue.
  
  Mauris interdum turpis eget est condimentum, vitae porttitor diam ornare.
  
  ![](https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/512px-Google-flutter-logo.svg.png)
  
  1. ajdsks
     1. this requires 3 spaces
     2. fdlefkl
  2. reorek
  3. fdpopore
 """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          Text(
            title,
            style: CustomTextStyle.h1(AppColors.primaryDark),
            textAlign: TextAlign.start,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Markdown(
              data: _markdownData + _markdownData,
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
                  codeblockDecoration: BoxDecoration(
                      color: AppColors.primaryLight.withOpacity(0.5))),
            ),
          ),
        ],
      ),
    );
  }
}
