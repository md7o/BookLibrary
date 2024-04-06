import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/features/book_content/book_content.dart';
import 'package:book_library/features/home/widget/books_classes.dart';
import 'package:book_library/features/home/widget/search_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RsearchEngine extends ConsumerWidget {
  RsearchEngine({super.key});

  // Define a TextEditingController for handling user input in the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<BooksModel>> booksData = ref.watch(booksContentProvider);

    // Filter books based on search query
    List<BooksModel> filteredBooks = [];

    if (booksData is AsyncData && _searchController.text.isNotEmpty) {
      filteredBooks = booksData.value!.where((book) => book.title!.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    } else if (booksData is AsyncData) {
      filteredBooks = booksData.value!.toList();
    }

    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bg1,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Hero(
            tag: "search_text_field",
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                height: 35,
                child: TextField(
                  autofocus: true,
                  controller: _searchController, // Connect the controller
                  onChanged: (value) => ref.refresh(
                    booksContentProvider,
                  ), // Trigger rebuild on text change
                  decoration: InputDecoration(
                    hintText: 'Search',
                    isDense: true,
                    fillColor: AppColors.bg2,
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.pop(context, 'cancelled');
                _searchController.clear();
                // ref.refresh(booksContentProvider); // Refresh the book list
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: booksData.when(
          data: (booksData) {
            return ListView.builder(
              itemCount: filteredBooks.length,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Hero(
                  tag: index,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookContent(index: index, cnt: filteredBooks[index]),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: SearchList(
                          title: "${filteredBooks[index].title}",
                          author: "${filteredBooks[index].author}",
                          coverBook: "${filteredBooks[index].coverbook}",
                          favButton: () {},
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, s) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
