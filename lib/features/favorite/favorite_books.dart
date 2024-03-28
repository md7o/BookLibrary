import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/features/home/widget/books_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_library/common/provider/favorite_provider.dart';

class FavoriteBooks extends ConsumerStatefulWidget {
  const FavoriteBooks({super.key});

  @override
  ConsumerState<FavoriteBooks> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<FavoriteBooks>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final favoriteBooks = ref.watch(favoriteBooksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Books'),
      ),
      body: ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return ListTile(
            title: Text(book.title ?? 'Unknown Title'),
            subtitle: Text(book.author ?? 'Unknown Author'),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                setState(() {
                  ref
                      .watch(favoriteBooksProvider.notifier)
                      .toggleFavorite(book);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
