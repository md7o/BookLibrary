import 'package:book_library/common/api/api.dart';
import 'package:book_library/common/models/book_model.dart';
import 'package:riverpod/riverpod.dart';

final booksContentProvider = FutureProvider<List<BooksModel>>((ref) async {
  return ref.watch(bookProvider).getBooks();
});
