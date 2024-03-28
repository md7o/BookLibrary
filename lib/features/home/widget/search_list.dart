import 'package:book_library/common/src/constants/padding.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  const SearchList({
    Key? key,
    required this.title,
    required this.author,
    required this.coverBook,
    required this.favButton,
  }) : super(key: key);

  final String title;
  final String author;
  final String coverBook;
  final VoidCallback? favButton;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100, // Set a specific height
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
