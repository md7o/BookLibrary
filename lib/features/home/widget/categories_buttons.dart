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
          _buildFilterButton(BookFilter.historical, 'History'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BookFilter filter, String label) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            setState(
              () {
                selectedFilter = filter;
                widget.onFilterChanged(selectedFilter);
              },
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: selectedFilter == filter ? 22 : 18,
            ),
          ),
        ),
        Container(
          width: 20,
          height: 2,
          decoration: BoxDecoration(
              color: selectedFilter == filter
                  ? AppColors.primary
                  : Colors.transparent),
        )
      ],
    );
  }
}
