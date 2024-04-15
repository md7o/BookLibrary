import 'package:book_library/common/src/constants/padding.dart';
import 'package:flutter/material.dart';

class Shelf extends StatelessWidget {
  const Shelf({
    super.key,
    required this.title,
    required this.iconContent,
    required this.arrowIcon,
    this.onTap,
  });

  final String title;
  final Icon iconContent;
  final Icon arrowIcon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.large, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              iconContent,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          arrowIcon,
        ],
      ),
    );
  }
}
