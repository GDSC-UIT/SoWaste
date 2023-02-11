import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/env_news/widgets/card_big_news.dart';
import 'package:sowaste/modules/env_news/widgets/news_item.dart';

class EnvNewsDoneScreen extends StatelessWidget {
  const EnvNewsDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: context.height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Text(
                      "Environment News",
                      style: CustomTextStyle.sub(AppColors.primary),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.search,
                      color: AppColors.info,
                    )
                  ],
                ),
              ),
              SizedBox(height: context.height * 0.045),
              const CardBigNews(
                imgUrl: "https://link.gdsc.app/4MgU4qt",
                title:
                    "Study reveals links between UK air pollution and mental ill-health",
                subtitle:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) => const NewsItem(
                    imgUrl: "https://link.gdsc.app/4MgU4qt",
                    title:
                        "Study reveals links between UK air pollution and mental ill-health",
                    subtitle:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
