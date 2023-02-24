import 'package:flutter/material.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';

class DictionaryCard extends StatelessWidget {
  DictionaryCard({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.type,
    required this.description,
  });
  final String imageUrl;
  final String label;
  final String type;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 5,
        shadowColor: AppColors.onBg.withOpacity(0.5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: GridTile(
            footer: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.3),
              ),
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: CustomTextStyle.bodyBold(AppColors.onSur),
                        ),
                        Text(
                          type,
                          style: CustomTextStyle.medium(AppColors.onBg),
                        ),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: CustomTextStyle.normal(AppColors.onBg),
                        ),
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                              ),
                              onPressed: () {
                                print("Clicked readmore");
                              },
                              child: Row(
                                children: const [
                                  Text("Read more"),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              )),
                        )
                      ]),
                ),
              ),
            ),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/images/placeholder.png'),
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
