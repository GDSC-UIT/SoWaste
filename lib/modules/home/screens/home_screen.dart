import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_assets/app_images.dart';
import 'package:sowaste/global_widget/bottom_navbar.dart';
import 'package:sowaste/modules/home/home_controller.dart';
import 'package:sowaste/modules/home/widgets/learn_more_button.dart';
import 'package:sowaste/modules/home/widgets/news_card.dart';
import 'package:sowaste/modules/home/widgets/pie_chart.dart';
import 'package:sowaste/modules/home/widgets/quiz_card.dart';
import 'package:sowaste/modules/home/widgets/to_dic_button.dart';

import '../widgets/detect_trash_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  int _count = 0;
  Row title(String text, [bool seeAllBtn = false]) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text,
              style: CustomTextStyle.sub(AppColors.onBg).copyWith(height: 1.5)),
          seeAllBtn
              ? Text(
                  "See All",
                  style: CustomTextStyle.normal(AppColors.primary),
                )
              : Container()
        ]);
  }

  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBar(
          title: Image.asset(AppImages.appLogo),
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              title("Overview"),
              // OptionCard(
              //   answer: "Choice",
              //   isRightAnswer: false,
              //   isAble: true,
              // ),
              Obx(
                () => (_homeController.count.value == 0 &&
                        _homeController.check.value == false)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You haven’t done any trash detecting yet.",
                            style: CustomTextStyle.bodyBold(AppColors.onBg)
                                .copyWith(height: 1.5),
                          ),
                          DetectingTrashButton(),
                          title("Your Quizzes"),
                          const ToDicButton(),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This week, you have detected [count] times ",
                            style: CustomTextStyle.bodyBold(AppColors.onBg)
                                .copyWith(height: 1.5),
                          ),
                          PieChart(),
                          const LearnMoreButton(),
                          title("Your Quizzes", true),
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              itemBuilder: ((context, index) => QuizCard(
                                  title: 'Plastic',
                                  subTitle: 'Hello',
                                  percentage: 0.6)),
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                            ),
                          )
                        ],
                      ),
              ),
              title("Environment News", true),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => NewsCard(
                    imageUrl: 'https://picsum.photos/id/237/200/300',
                    title:
                        'Study reveals links between UK air pollution and mental ill-health',
                  ),
                  itemCount: 4,
                ),
              ),
            ]),
          ),
        ));
  }
}
