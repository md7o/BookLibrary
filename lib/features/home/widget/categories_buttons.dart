import 'package:book_library/common/enums/buttons_filter.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/home/widget/book_options_pages/book_options.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Row(
          key: Key(selectedFilter.toString()),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const BookOptions(),
            _buildFilterButton(BookFilter.all, '⚪ All'),
            _buildFilterButton(BookFilter.stories, '📖 Stories'),
            _buildFilterButton(BookFilter.fiction, '🔮 Fiction'),
            _buildFilterButton(BookFilter.historical, '🌍 History'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BookFilter filter, String label) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ElevatedButton(
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
              backgroundColor: selectedFilter == filter ? AppColors.primary : Colors.transparent,
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
