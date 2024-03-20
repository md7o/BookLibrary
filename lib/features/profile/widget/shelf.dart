import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:flutter/material.dart';

class Shelf extends StatelessWidget {
  const Shelf({
    super.key,
    required this.title,
    required this.iconContent,
    this.onTap,
  });

  final String title;
  final Icon iconContent;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: iconContent,
      trailing: Wrap(
        spacing: 5, // space between two icons
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.primary),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.medium),
              child: Text(
                '+9',
                style: TextStyle(fontSize: AppFontSize.small),
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios), // icon-1
        ],
      ),
      onTap: onTap,
    );
  }
}
