import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/modules/env_news/screens/env_news_detailed_screen.dart';
import 'package:sowaste/modules/env_news/widgets/news_item.dart';

import 'env_news.dart';

class EnvNewsSearchDelegate extends SearchDelegate {
  List<EnvNews> searchNews = [
    EnvNews(
      imgUrl: "https://link.gdsc.app/4MgU4qt",
      title: "Mot cai ban",
      subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    EnvNews(
      imgUrl: "https://link.gdsc.app/4MgU4qt",
      title: "Hai cai ban",
      subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    EnvNews(
      imgUrl: "https://link.gdsc.app/4MgU4qt",
      title: "Ba cai ban",
      subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    EnvNews(
      imgUrl: "https://link.gdsc.app/4MgU4qt",
      title: "Bon cai ban",
      subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<EnvNews> matchQuery = [];
    for (var element in searchNews) {
      if (element.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => NewsItem(
        onTap: () =>
            Get.to(() => EnvsNewsDetailtedScreen(envNews: matchQuery[index])),
        envNews: matchQuery[index],
      ),
      separatorBuilder: (_, __) => const SizedBox(
        height: 16,
      ),
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<EnvNews> matchQuery = [];
    for (var element in searchNews) {
      if (query == '') break;
      if (element.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => NewsItem(
        onTap: () =>
            Get.to(() => EnvsNewsDetailtedScreen(envNews: matchQuery[index])),
        envNews: matchQuery[index],
      ),
      separatorBuilder: (_, __) => const SizedBox(
        height: 16,
      ),
      itemCount: matchQuery.length,
    );
  }
}
