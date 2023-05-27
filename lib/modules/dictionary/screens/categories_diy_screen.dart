import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/modules/dictionary/widgets/list_categories.dart';
import 'package:sowaste/modules/dictionary/widgets/list_diy.dart';

class CategoriesandDIYscreen extends StatefulWidget {
  const CategoriesandDIYscreen({super.key});

  @override
  State<CategoriesandDIYscreen> createState() => _CategoriesandDIYscreenState();
}

class _CategoriesandDIYscreenState extends State<CategoriesandDIYscreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
              height: screenHeight * (240 / 926),
              width: screenWidth,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "Waste dictionary",
                      style: CustomTextStyle.dictionaryTitle(
                          AppColors.dictionaryTitleColor),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Search type of waste here",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: AppColors.dictionaryTextField,
                      ),
                    ),
                  ),
                  Spacer(),
                  TabBar(
                    labelStyle: CustomTextStyle.tabTitle(),
                    unselectedLabelColor: AppColors.unselectedTabTitle,
                    labelColor: Colors.green,
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Tab(
                        text: 'Categories',
                      ),
                      Tab(
                        text: 'DIY',
                      )
                    ],
                    controller: tabController,
                  ),
                ],
              )),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TabBarView(
                children: [
                  const ListCategories(),
                  const ListDIY(),
                ],
                controller: tabController,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(),
    );
  }
}
