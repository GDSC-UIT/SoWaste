import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class RewardAppbar extends StatelessWidget {
  const RewardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Text(
            "Rewards",
            style: CustomTextStyle.heading(),
          ),
          Spacer(),
          Icon(
            Icons.qr_code,
            color: AppColors.primaryDark,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
