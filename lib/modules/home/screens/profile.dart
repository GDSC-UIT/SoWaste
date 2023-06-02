import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/data/services/auth_service.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/dictionary/dictionary_controller.dart';
import 'package:sowaste/modules/home/widgets/avatar.dart';
import 'package:sowaste/modules/home/widgets/profile_selection.dart';
import 'package:sowaste/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ArrowBackAppBar(title: "Profile"),
      body: Column(children: [
        const SizedBox(
          height: 31,
        ),
        Center(
          child: Avatar(
            title: DataCenter.user!.name,
            image: DataCenter.user!.displayImage,
          ),
        ),
        const SizedBox(
          height: 39,
        ),
        ProfileSelection(
          title: "Saved",
          icon: Icons.bookmark,
          onTap: () => Get.toNamed(AppRoutes.savedTypesPage),
        ),
        const SizedBox(
          height: 16,
        ),
        ProfileSelection(
          title: "Quiz Results",
          icon: Icons.checklist,
          onTap: () => Get.toNamed(
            AppRoutes.quizzesPage,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ProfileSelection(
          title: "Log out",
          icon: Icons.logout_rounded,
          color: AppColors.error,
          onTap: () async {
            await AuthServices().signOut();
          },
        ),
        const SizedBox(
          height: 48,
        ),
        ProfileSelection(title: "Policy", icon: Icons.assignment),
        const SizedBox(
          height: 16,
        ),
        ProfileSelection(title: "About SoWaste", icon: Icons.assignment),
        const SizedBox(
          height: 16,
        ),
        ProfileSelection(title: "Feedback", icon: Icons.assignment),
      ]),
    );
  }
}
