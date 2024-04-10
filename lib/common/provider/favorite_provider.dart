import 'package:book_library/common/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class FavoriteBooksNotifier extends StateNotifier<List<BooksModel>> {
  FavoriteBooksNotifier() : super([]);

  final _hiveBoxName = 'favorite_books';

  Future<void> init() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path); // Initialize Hive with app directory path
    final hiveBox = await Hive.openBox(_hiveBoxName);
    final List<dynamic> booksJson = hiveBox.get('books', defaultValue: []);
    state = booksJson.map((json) => BooksModel.fromJson(Map<String, dynamic>.from(json))).toList();
  }

  Future<void> toggleFavorite(BooksModel book) async {
    final hiveBox = await Hive.openBox(_hiveBoxName);
    final List<BooksModel> updatedBooks = List.from(state); // Create a copy of current state
    if (updatedBooks.contains(book)) {
      updatedBooks.remove(book);
    } else {
      updatedBooks.add(book);
    }
    state = updatedBooks; // Update the state
    final List<Map<String, dynamic>> updatedBooksJson = updatedBooks.map((book) => book.toJson()).toList();
    await hiveBox.put('books', updatedBooksJson);
  }

  bool isClick(BooksModel book) {
    return state.contains(book);
  }
}

final favoriteBooksProvider = StateNotifierProvider<FavoriteBooksNotifier, List<BooksModel>>((ref) {
  final notifier = FavoriteBooksNotifier();
  ref.onDispose(() => notifier.dispose());
  notifier.init(); // Initialize Hive box when provider is first accessed
  return notifier;
});
