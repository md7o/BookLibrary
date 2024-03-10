import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_library/common/provider/favorite_provider.dart';

class FavoriteBooks extends ConsumerWidget {
  const FavoriteBooks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProviderData = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Books'),
      ),
      body: ListView.builder(
        itemCount: favoriteProviderData.favorites.length,
        itemBuilder: (context, index) {
          final book = favoriteProviderData.favorites[index];
          return ListTile(
            title: Text(book.title!),
            subtitle: Text(book.author!),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                favoriteProviderData.toggleFavorite(book);
              },
            ),
          );
        },
      ),
    );
  }
}
