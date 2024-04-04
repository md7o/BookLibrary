import 'package:book_library/common/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class FavoriteBooksNotifier extends StateNotifier<List<BooksModel>> {
  FavoriteBooksNotifier() : super([]);

  final _hiveBoxName = 'favorite_books';

  Future<void> init() async {
    final hiveBox = await Hive.openBox(_hiveBoxName);
    final List<dynamic> booksJson = hiveBox.get('books', defaultValue: []);
    state = booksJson
        .map((json) => BooksModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<void> toggleFavorite(BooksModel book) async {
    final hiveBox = await Hive.openBox(_hiveBoxName);
    if (state.contains(book)) {
      state.remove(book);
    } else {
      state.add(book);
    }
    final List<Map<String, dynamic>> updatedBooksJson =
        state.map((book) => book.toJson()).toList();
    await hiveBox.put('books', updatedBooksJson);
  }

  bool isClick(BooksModel book) {
    return state.contains(book);
  }
}

final favoriteBooksProvider =
    StateNotifierProvider<FavoriteBooksNotifier, List<BooksModel>>((ref) {
  final notifier = FavoriteBooksNotifier();
  ref.onDispose(() => notifier.dispose());
  notifier.init(); // Initialize Hive box when provider is first accessed
  return notifier;
});
