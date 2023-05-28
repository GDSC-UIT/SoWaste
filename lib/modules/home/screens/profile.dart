import 'package:flutter/material.dart';
import 'package:sowaste/global_widget/arrow_back_app_bar.dart';
import 'package:sowaste/modules/home/widgets/avatar.dart';
import 'package:sowaste/modules/home/widgets/profile_selection.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowBackAppBar(title: "Profile"),
      body: Column(children: [
        SizedBox(
          height: 31,
        ),
        Center(
          child: Avatar(
            title: "GDSC-UIT",
            image:
                'https://i.pinimg.com/736x/27/96/c7/2796c781d37c99d6e0e7ba5d026ea476.jpg',
          ),
        ),
        SizedBox(
          height: 39,
        ),
        ProfileSelection(title: "Saved", icon: Icons.bookmark),
        SizedBox(
          height: 16,
        ),
        ProfileSelection(title: "Quiz Results", icon: Icons.checklist),
        SizedBox(
          height: 48,
        ),
        ProfileSelection(title: "Policy", icon: Icons.assignment),
        SizedBox(
          height: 16,
        ),
        ProfileSelection(title: "About SoWaste", icon: Icons.assignment),
        SizedBox(
          height: 16,
        ),
        ProfileSelection(title: "Feedback", icon: Icons.assignment),
      ]),
    );
  }
}
