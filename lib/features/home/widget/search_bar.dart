import 'package:book_library/common/src/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35,
          child: TextField(
              decoration: InputDecoration(
            hintText: 'Search',
            isDense: true,
            filled: true,
            fillColor: AppColors.bg1,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(8),
          )),
        ),
      ],
    );
  }
}
