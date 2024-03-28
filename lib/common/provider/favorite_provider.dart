import 'package:book_library/common/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteBooksNotifier extends StateNotifier<List<BooksModel>> {
  FavoriteBooksNotifier() : super([]);

  void toggleFavorite(BooksModel book) {
    if (state.contains(book)) {
      state.remove(book);
    } else {
      state.add(book);
    }

    print('Favorite status toggled for book: $book');
  }
}

final favoriteBooksProvider =
    StateNotifierProvider<FavoriteBooksNotifier, List<BooksModel>>((ref) {
  return FavoriteBooksNotifier();
});
