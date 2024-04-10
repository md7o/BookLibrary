import 'dart:convert';

import 'package:book_library/common/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class BookApi {
  String bookUrl = 'https://md7o.github.io/host_api/content.json';

  Future<List<BooksModel>> getBooks() async {
    Response response = await get(Uri.parse(bookUrl));
    if (response.statusCode == 200) {
      final List result = (jsonDecode(response.body));
      return result.map(((e) => BooksModel.fromJson(e))).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final bookProvider = Provider<BookApi>((ref) => BookApi());
