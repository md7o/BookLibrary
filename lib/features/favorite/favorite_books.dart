import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/book_content.dart';
import 'package:book_library/features/home/widget/books_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_library/common/provider/favorite_provider.dart';

class FavoriteBooks extends ConsumerStatefulWidget {
  const FavoriteBooks({super.key});

  @override
  ConsumerState<FavoriteBooks> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<FavoriteBooks> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final favoriteBooks = ref.watch(favoriteBooksProvider);

    if (favoriteBooks.isEmpty) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Favorite Books'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const Stack(
          children: [
            AnimationWall(),
            Center(child: Text('No favorite books yet.')),
          ],
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Favorite Books'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const AnimationWall(),
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteBooks.length,
                  itemBuilder: (context, index) {
                    final book = favoriteBooks[index];
                    return Hero(
                      tag: index,
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookContent(
                                index: index,
                                cnt: book,
                              ),
                            ),
                          ),
                          child: BooksClasses(
                            title: book.title ?? 'Unknown Title',
                            author: book.author ?? 'Unknown Author',
                            classification: "Type: ${book.classification ?? 'Unknown Author'}",
                            coverBook: "${book.coverbook}",
                            child: IconButton(
                              icon: const Icon(
                                Icons.bookmark_remove_rounded,
                                size: 30,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  ref.watch(favoriteBooksProvider.notifier).toggleFavorite(book);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    );

                    // ListTile(
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
