import 'package:flutter/material.dart';
import 'package:sowaste/core/values/app_constant.dart';
import 'package:sowaste/modules/base/base_controller.dart';

class LearnMoreButton extends StatelessWidget {
  const LearnMoreButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              // Change your radius here
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        onPressed: () {
          BaseController.changeIndexPage(1);
        },
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 5,
                  child: FittedBox(
                    child: Text(
                      "Don't know how to sort your waste?",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Row(
                  children: const [
                    FittedBox(child: Text("Learn more")),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
