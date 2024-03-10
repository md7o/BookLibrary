import 'package:book_library/common/enums/buttons_filter.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:flutter/material.dart';

class CategoriesButtons extends StatefulWidget {
  final ValueChanged<BookFilter> onFilterChanged;

  const CategoriesButtons({
    Key? key,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _CategoriesButtonsState createState() => _CategoriesButtonsState();
}

class _CategoriesButtonsState extends State<CategoriesButtons> {
  BookFilter selectedFilter = BookFilter.all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton(BookFilter.all, 'All'),
          _buildFilterButton(BookFilter.stories, 'Stories'),
          _buildFilterButton(BookFilter.fiction, 'Fiction'),
          _buildFilterButton(BookFilter.historical, 'Historical'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BookFilter filter, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFilter = filter;
          widget.onFilterChanged(selectedFilter);
        });
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: selectedFilter == filter ? AppColors.primary : null,
          padding: const EdgeInsets.symmetric(horizontal: 15)),
      child: Text(
        label,
        style: TextStyle(
            color: selectedFilter == filter ? Colors.white : null,
            fontSize: 15),
      ),
    );
  }
}
