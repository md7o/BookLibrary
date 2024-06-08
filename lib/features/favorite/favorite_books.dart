import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/texts_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteBooks extends ConsumerStatefulWidget {
  const FavoriteBooks({super.key});

  @override
  ConsumerState<FavoriteBooks> createState() => _FavoriteBooksState();
}

class _FavoriteBooksState extends ConsumerState<FavoriteBooks> with TickerProviderStateMixin {
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
      appBar: AppBar(
        title: const Text('Favorite'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          FadeTransition(
            opacity: _Animation,
            child: booksData.when(
              data: (booksData) {
                List<BooksModel> booksList = booksData.toList();

                bool anyBookFavored = false;

                List<Widget> favoriteBooks = [];
                for (var index = 0; index < booksList.length; index++) {
                  final book = booksList[index];
                  final box = Hive.box('saveBox');
                  final key = 'bookfavorite_${book.title}_${book.id}';
                  final isBookfavorite = box.get(key, defaultValue: false);

                  if (isBookfavorite) {
                    anyBookFavored = true;
                    favoriteBooks.add(
                      InkWell(
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
                                                    borderRadius: BorderRadius.circular(3),
                                                    child: Image.asset(
                                                      book.coverbook.toString(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: AppPadding.small),
                                                child: Column(
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
                                                    const SizedBox(height: 5),
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
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                box.put(key, !isBookfavorite);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.delete_forever_rounded,
                                              color: Colors.red,
                                              size: 30,
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
                      ),
                    );
                  }
                }

                if (!anyBookFavored) {
                  return const Center(
                    child: Text('There are no favorite book'),
                  );
                }

                return ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: favoriteBooks,
                );
              },
              error: (error, s) => const Center(child: Text('Check the internet connection')),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
