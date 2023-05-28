import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/widgets/list_categories.dart';
import 'package:sowaste/modules/dictionary/widgets/list_diy.dart';

class CategoriesandDIYscreen extends StatefulWidget {
  const CategoriesandDIYscreen({Key? key}) : super(key: key);

  @override
  _CategoriesandDIYscreenState createState() => _CategoriesandDIYscreenState();
}

class _CategoriesandDIYscreenState extends State<CategoriesandDIYscreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final DictionaryController _controller = Get.find();

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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0.2,
        title: Center(
          child: Text(
            "Waste Dictionary",
            style: CustomTextStyle.h4(AppColors.primary),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * (200 / 926),
            width: screenWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _controller.searchInput,
                    onChanged: (value) => _controller.filterWord(value),
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Search type of waste here",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.dictionaryTextField,
                    ),
                  ),
                ),
                TabBar(
                  labelStyle: CustomTextStyle.tabTitle(),
                  unselectedLabelColor: AppColors.unselectedTabTitle,
                  labelColor: Colors.green,
                  indicatorColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      text: 'Categories',
                    ),
                    Tab(
                      text: 'DIY',
                    ),
                  ],
                  controller: tabController,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBarView(
                controller: tabController,
                children: [
                  ListCategories(),
                  const ListDIY(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(),
    );
  }
}
