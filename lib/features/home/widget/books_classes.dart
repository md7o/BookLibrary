import 'package:book_library/common/src/constants/padding.dart';
import 'package:flutter/material.dart';

class BooksClasses extends StatefulWidget {
  const BooksClasses({
    Key? key,
    required this.title,
    required this.author,
    required this.price,
    required this.coverBook,
    required this.favButton,
  }) : super(key: key);

  final String title;
  final String author;
  final String price;
  final String coverBook;
  final VoidCallback? favButton;

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
          height: 160, // Set a specific height
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border

                  child: Image.network(widget.coverBook, fit: BoxFit.cover),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.small),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        //==================> the first List
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.author,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.price,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          IconButton(
                            onPressed: () {
                              widget.favButton;
                              setState(() {
                                isClick = !isClick;
                              });
                            },
                            icon: isClick
                                ? const Icon(
                                    Icons.favorite,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 30,
                                  ),
                          )
                        ],
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
