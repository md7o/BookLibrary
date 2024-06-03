import 'dart:async';
import 'dart:math';

import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif/gif.dart';

class RandomBook extends ConsumerStatefulWidget {
  const RandomBook({super.key});

  @override
  ConsumerState<RandomBook> createState() => _RandomBookState();
}

class _RandomBookState extends ConsumerState<RandomBook> with TickerProviderStateMixin {
  bool showGif = true;

  late final GifController controller;
  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this);

    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        showGif = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showGif)
                  const Column(
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 6,
                      ),
                      SizedBox(height: 20),
                      Text('Randomization')
                    ],
                  ),
                if (!showGif)
                  booksData.when(
                    data: (booksData) {
                      List<BooksModel> booksList = booksData.toList();
                      Random random = Random();

                      booksList.shuffle(random);

                      return ListView.builder(
                        itemCount: 1,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          final book = booksList[index];

                          return InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookDetails(
                                    index: index,
                                    cnt: booksList[index],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    book.coverbook.toString(),
                                    // fit: BoxFit.cover,
                                    scale: 5,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  book.title.toString(),
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height <= 700 ? 15 : 17,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.7,
                                  child: Text(
                                    book.author.toString(),
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height <= 700 ? 13 : 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    error: (error, s) => Text(error.toString()),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
