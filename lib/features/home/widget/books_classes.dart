import 'package:book_library/common/src/constants/padding.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BooksClasses extends StatefulWidget {
  const BooksClasses({
    Key? key,
    required this.title,
    required this.author,
    required this.coverBook,
    required this.classification,
    this.child,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String author;
  final String coverBook;
  final String classification;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  State<BooksClasses> createState() => _BooksClassesState();
}

class _BooksClassesState extends State<BooksClasses> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border

                  child: Image.network(
                    widget.coverBook,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.small),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          Opacity(
                            opacity: 0.8,
                            child: Text(
                              widget.author,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: widget.onTap,
                        child: widget.child,
                      ),
                      Text(
                        widget.classification,
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
