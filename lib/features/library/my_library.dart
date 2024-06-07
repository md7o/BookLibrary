import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/texts_books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyLibrary extends ConsumerStatefulWidget {
  const MyLibrary({super.key});

  @override
  ConsumerState<MyLibrary> createState() => _MyLibraryState();
}

class _MyLibraryState extends ConsumerState<MyLibrary> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge, vertical: AppPadding.medium),
                child: Text(
                  'Library',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height <= 700 ? 40 : 50,
                  ),
                ),
              ),
              booksData.when(
                data: (booksData) {
                  List<BooksModel> booksList = booksData.toList();

                  // Filter bookmarked books
                  // final bookmarkedBooks = booksList.where((book) {
                  //   final box = Hive.box('saveBox');
                  //   final key = 'bookmark_${book.title}_${currentIndex}';
                  //   return box.get(key, defaultValue: false);
                  // }).toList();

                  // if (bookmarkedBooks.isEmpty) {
                  //   return const Center(
                  //     child: Text("There are no bookmarked books."),
                  //   );
                  // }

                  return ListView.builder(
                    itemCount: booksList.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      final book = booksList[index];

                      final box1 = Hive.box('saveBox');
                      final key1 = 'bookread_${book.title}_${book.id}';
                      final isBookRead = box1.get(key1, defaultValue: false);

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return TextsBooks(
                                  character: book,
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            if (isBookRead)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height <= 700 ? 100 : 150,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                                        child: Row(
                                          children: [
                                            Hero(
                                              tag: index,
                                              child: Material(
                                                type: MaterialType.transparency,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5), // Image border

                                                  child: Image.asset(
                                                    book.coverbook.toString(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.small),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        book.title ?? 'Unknown Title',
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.height <= 700 ? 15 : 20,
                                                        ),
                                                      ),
                                                      Opacity(
                                                        opacity: 0.8,
                                                        child: Text(
                                                          book.author ?? 'Unknown Author',
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(context).size.height <= 700 ? 13 : 18,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 1),
                                                      Opacity(
                                                        opacity: 0.5,
                                                        child: Text(
                                                          book.classification.toString(),
                                                          style: const TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Opacity(
                                      opacity: 0.4,
                                      child: Divider(
                                        indent: 100,
                                        endIndent: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );

                      // return Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).push(
                      //         MaterialPageRoute(
                      //           builder: (context) {
                      //             return TextsBooks(
                      //               character: book,
                      //             );
                      //           },
                      //         ),
                      //       );
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: Image.asset(
                      //           book.coverbook!,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
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
        ],
      ),
    );
  }
}
