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

class _MyLibraryState extends ConsumerState<MyLibrary> with TickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _Animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this, value: 0);
    _Animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          FadeTransition(
            opacity: _Animation,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.xlarge, left: AppPadding.xlarge, top: AppPadding.xlarge),
                  child: Text(
                    'Library',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > 360 ? 50 : 40,
                    ),
                  ),
                ),
                const Opacity(
                  opacity: 0.4,
                  child: Divider(
                    indent: 35,
                    endIndent: 10,
                  ),
                ),
                const SizedBox(height: 10),
                booksData.when(
                  data: (booksData) {
                    List<BooksModel> booksList = booksData.toList();

                    List<BooksModel> readBooks = booksList.where((book) {
                      final box1 = Hive.box('saveBox');
                      final key1 = 'bookread_${book.title}_${book.id}';
                      return box1.get(key1, defaultValue: false);
                    }).toList();

                    if (readBooks.isEmpty) {
                      return const Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: AppPadding.medium),
                              child: Text(
                                'Library is Empty',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: AppPadding.small),
                              child: Text(
                                'Browse books to add to the library',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

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
                                        height: 140,
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
                                                            fontSize: MediaQuery.of(context).size.width > 360 ? 20 : 15,
                                                          ),
                                                        ),
                                                        Opacity(
                                                          opacity: 0.8,
                                                          child: Text(
                                                            book.author ?? 'Unknown Author',
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 13,
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
                                      const SizedBox(height: 5),
                                      const Opacity(
                                        opacity: 0.4,
                                        child: Divider(
                                          indent: 100,
                                          endIndent: 10,
                                        ),
                                      ),
                                      // IconButton(
                                      //   icon: Icon(Icons.delete),
                                      //   onPressed: () {
                                      //     final box1 = Hive.box('saveBox');
                                      //     final key1 = 'bookread_${book.title}_${book.id}';
                                      //     box1.delete(key1);

                                      //     setState(() {
                                      //       // Trigger UI update to reflect the deletion
                                      //     });
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  error: (error, s) => const Center(child: Text('Check the internet connection')),
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
