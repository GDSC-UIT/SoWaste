import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_themes.dart';

import '../../../core/themes/app_colors.dart';
import '../widgets/card_big_news.dart';
import '../widgets/news_item.dart';

class EnvNewsSearchScreen extends StatelessWidget {
  const EnvNewsSearchScreen({super.key});

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
                    const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 60,
                              offset: Offset(0, 4),
                              color: AppColors.dropShadow,
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Find your interested news here...",
                            hintStyle: CustomTextStyle.normal(AppColors.info),
                          ),
                        ),
                      ),
                    ),
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
