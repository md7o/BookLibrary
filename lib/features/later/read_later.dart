import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/categories_provider/book_mark_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/book_details.dart';
import 'package:book_library/features/book_content/texts_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tuple/tuple.dart';

class ReadLater extends ConsumerStatefulWidget {
  const ReadLater({super.key});

  @override
  ConsumerState<ReadLater> createState() => _ReadLaterState();
}

class _ReadLaterState extends ConsumerState<ReadLater> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Read Later'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          booksData.when(
            data: (booksData) {
              List<BooksModel> booksList = booksData.toList();

              return ListView.builder(
                  itemCount: booksList.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    final book = booksList[index];

                    final box = Hive.box('saveBox');
                    final key = 'bookmark_${book.title}_${book.id}';
                    final isBookmarked = box.get(key, defaultValue: false);

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
                          if (isBookmarked)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Hero(
                                                tag: index,
                                                child: Material(
                                                  type: MaterialType.transparency,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(3), // Image border

                                                    child: Image.network(
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
                                                            fontSize: MediaQuery.of(context).size.height <= 700 ? 15 : 18,
                                                          ),
                                                        ),
                                                        Opacity(
                                                          opacity: 0.8,
                                                          child: Text(
                                                            book.author ?? 'Unknown Author',
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(context).size.height <= 700 ? 13 : 15,
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
                                              // Text(isBookmarked)
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (context, animation, secondaryAnimation) {
                                                    return BookDetails(
                                                      // transitionAnimation: animation,
                                                      index: index,
                                                      cnt: book,
                                                    );
                                                  },
                                                  transitionDuration: const Duration(milliseconds: 400),
                                                  reverseTransitionDuration: const Duration(milliseconds: 500),
                                                ),
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                                              foregroundColor: Colors.white,
                                              backgroundColor: const Color(0x16151515),
                                            ),
                                            child: Text(
                                              "Continue",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height <= 700 ? 10 : 15,
                                              ),
                                            ),
                                          )
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
                  });
            },
            error: (error, s) => Text(error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
