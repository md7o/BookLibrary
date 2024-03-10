import 'package:book_library/common/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<BooksModel> _favorites = [];

  List<BooksModel> get favorites => _favorites;

  bool isBookFavorite(BooksModel book) {
    return _favorites.contains(book);
  }

  void toggleFavorite(BooksModel book) {
    if (_favorites.contains(book)) {
      _favorites.remove(book);
    } else {
      _favorites.add(book);
    }
    notifyListeners();
  }
}

final favoriteProvider = ChangeNotifierProvider<FavoriteProvider>((ref) {
  return FavoriteProvider();
});
