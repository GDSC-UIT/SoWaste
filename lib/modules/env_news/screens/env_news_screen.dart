import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/env_news/screens/env_news_detailed_screen.dart';
import 'package:sowaste/modules/env_news/widgets/card_big_news.dart';
import 'package:sowaste/modules/env_news/widgets/news_item.dart';

import '../env_news.dart';
import '../env_news_search_delegate.dart';

class EnvNewsScreen extends StatefulWidget {
  const EnvNewsScreen({super.key});

  @override
  State<EnvNewsScreen> createState() => _EnvNewsScreenState();
}

class _EnvNewsScreenState extends State<EnvNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Environment News",
            style: CustomTextStyle.sub(AppColors.primary),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: AppColors.info,
              ),
              onPressed: () => showSearch(
                context: context,
                delegate: EnvNewsSearchDelegate(),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CardBigNews(
                  envNews: EnvNews(
                    imgUrl: "https://link.gdsc.app/4MgU4qt",
                    title:
                        "Study reveals links between UK air pollution and mental ill-health",
                    subtitle:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  ),
                ),
                const SizedBox(height: 24),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => NewsItem(
                    onTap: () => Get.to(() => EnvsNewsDetailtedScreen(
                          envNews: EnvNews(
                            imgUrl: "https://link.gdsc.app/4MgU4qt",
                            title:
                                "Study reveals links between UK air pollution and mental ill-health",
                            subtitle:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          ),
                        )),
                    envNews: EnvNews(
                      imgUrl: "https://link.gdsc.app/4MgU4qt",
                      title:
                          "Study reveals links between UK air pollution and mental ill-health",
                      subtitle:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
