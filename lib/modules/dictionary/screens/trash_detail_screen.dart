import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/global_widget/app_button.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/base/base_controller.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/dictionary/screens/question_screen.dart';
import 'package:sowaste/modules/dictionary/widgets/diy_card.dart';
import '../../../data/models/trash.dart';

class TrashDetailScreen extends StatelessWidget {
  const TrashDetailScreen({
    super.key,
  });

  Widget unorderList(List<dynamic>? itemList, Icon icon) {
    return itemList != null
        ? Column(
            children: itemList
                .map((e) => ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: const EdgeInsets.all(0),
                      leading: icon,
                      title: Text(
                        e,
                        style: CustomTextStyle.normal(AppColors.text),
                      ),
                    ))
                .toList())
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    final DictionaryController dictionaryController = Get.find();
    dictionaryController.isSaved.value = false;

    IconButton save(Trash trash) {
      return IconButton(
        onPressed: () => {dictionaryController.saveTrash(trash)},
        icon: Obx(() {
          dictionaryController.isSaved.value = false;
          for (Trash t in dictionaryController.savedTrashList) {
            if (t.id == trash.id) {
              dictionaryController.isSaved.value = true;
              break;
            }
          }

          return dictionaryController.isSaved.value
              ? const Icon(
                  Icons.bookmark,
                  size: 32,
                  color: AppColors.secondary,
                )
              : const Icon(
                  Icons.bookmark_outline,
                  size: 32,
                );
        }),
      );
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: const ArrowBackAppBar(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton(
                buttonText: "DONATE TO RECEIVE RECYCLING POINT",
                onPressedFunction: () {
                  Get.back();
                  BaseController.changeIndexPage(4);
                }),
            Obx(() => dictionaryController.currentQuiz.isNotEmpty
                ? AppButton(
                    buttonText: "START QUIZ",
                    color: AppColors.background,
                    textColor: Colors.black,
                    onPressedFunction: () async {
                      Get.to(() => QuestionScreen());
                    })
                : Container()),
          ],
        ),
        body: Obx(() {
          if (dictionaryController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else {
            final Trash trash = dictionaryController.currentTrash.value;
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              trash.name,
                              style: CustomTextStyle.h2(AppColors.primary)
                                  .copyWith(height: 1.2),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          save(trash)
                        ],
                      ),
                      Image.network(trash.displayImage),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              8), // Tuỳ chỉnh bo góc container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.1), // Màu của shadow và độ mờ
                              spreadRadius: 2, // Bán kính của shadow
                              blurRadius: 5, // Độ mờ của shadow
                              offset: const Offset(
                                  0, 2), // Vị trí tạo shadow (ngang, dọc)
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Recyclable",
                                  style:
                                      CustomTextStyle.normal(AppColors.gray400),
                                ),
                                ListTile(
                                  leading: trash.isRecyable!
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                        )
                                      : const Icon(
                                          Icons.close_rounded,
                                          color: AppColors.error,
                                        ),
                                  title: Text(
                                    trash.isRecyable!
                                        ? "Possible"
                                        : "Not possible",
                                    style: trash.isRecyable!
                                        ? CustomTextStyle.normal(
                                            AppColors.primary)
                                        : CustomTextStyle.normal(
                                            AppColors.error),
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Is organic",
                                  style:
                                      CustomTextStyle.normal(AppColors.gray400),
                                ),
                                ListTile(
                                  leading: trash.isOrganic!
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                        )
                                      : const Icon(
                                          Icons.close_rounded,
                                          color: AppColors.error,
                                        ),
                                  title: Text(
                                    trash.isOrganic! ? "Yes" : "No",
                                    style: trash.isOrganic!
                                        ? CustomTextStyle.normal(
                                            AppColors.primary)
                                        : CustomTextStyle.normal(
                                            AppColors.error),
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                      Text(
                        trash.shortDescription!,
                        style: CustomTextStyle.normal(AppColors.text),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Types of ${trash.name.toLowerCase()}",
                        style: CustomTextStyle.title(AppColors.text),
                      ),
                      unorderList(
                          trash.types!,
                          const Icon(
                            Icons.circle,
                            size: 4,
                          )),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        "${trash.reItems["title"]}",
                        style: CustomTextStyle.title(AppColors.text),
                      ),
                      unorderList(
                          trash.reItems["data"],
                          const Icon(
                            Icons.check_circle_sharp,
                            color: AppColors.primary,
                            size: 24,
                          )),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        "${trash.nonReItems["title"]}",
                        style: CustomTextStyle.title(AppColors.text),
                      ),
                      unorderList(
                          trash.nonReItems["data"],
                          const Icon(
                            Icons.close_sharp,
                            color: AppColors.error,
                            size: 24,
                          )),
                      const SizedBox(
                        height: 18,
                      ),
                      trash.howToRe!.isNotEmpty
                          ? Text(
                              "How to recycle? ",
                              style: CustomTextStyle.title(AppColors.text),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          trash.howToRe!,
                          style: CustomTextStyle.normal(AppColors.text),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      trash.goodToKnow!.isNotEmpty
                          ? Text(
                              "Good to know",
                              style: CustomTextStyle.title(AppColors.text),
                            )
                          : Container(),
                      trash.goodToKnow!.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFC8EFDA),
                                borderRadius: BorderRadius.circular(
                                    10), // Bo góc với bán kính 10
                              ),
                              padding: const EdgeInsets.all(
                                  24), // Khoảng cách lề bên trong container
                              child: Text(
                                trash.goodToKnow!,
                                style: CustomTextStyle.normal(AppColors.text),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 36,
                      ),
                      Obx(() => dictionaryController.currentDIYList.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                color: AppColors.primary,
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Related DIY",
                                    style: CustomTextStyle.title(Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  SizedBox(
                                    height: 220,
                                    child: ListView.builder(
                                      itemCount: dictionaryController
                                          .currentDIYList.length,
                                      itemBuilder: ((context, index) {
                                        return SizedBox(
                                          width: 320,
                                          child: DIYCard(
                                            title: dictionaryController
                                                .currentDIYList[index].title,
                                            image: dictionaryController
                                                .currentDIYList[index]
                                                .displayImage,
                                            onTap: () async {
                                              await dictionaryController
                                                  .getDIYDetails(
                                                      dictionaryController
                                                          .currentDIYList[index]
                                                          .id);
                                            },
                                          ),
                                        );
                                      }),
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()),
                      SizedBox(
                        height: dictionaryController.currentQuiz.isNotEmpty
                            ? 200
                            : 8,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }));
  }
}
