import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/favorite_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/book_content/book_content.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RsearchEngine extends ConsumerStatefulWidget {
  const RsearchEngine({super.key});

  @override
  ConsumerState<RsearchEngine> createState() => _RsearchEngine();
}

final TextEditingController _searchController = TextEditingController();

class _RsearchEngine extends ConsumerState<RsearchEngine> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<BooksModel>> booksData = ref.watch(booksContentProvider);
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
              itemCount: booksData.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                final book = booksData[index];

                return Hero(
                  tag: index,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookContent(
                            index: index,
                            cnt: booksData[index],
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10), // Image border

                                          child: Image.network(
                                            book.coverbook.toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppPadding.small),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                book.title.toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 0.8,
                                                child: Text(
                                                  book.author.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 1),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    book.classification.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      ref.watch(favoriteBooksProvider.notifier).isClick(book)
                                                          ? Icons.bookmark_rounded
                                                          : Icons.bookmark_add_outlined,
                                                      size: 25,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        ref.watch(favoriteBooksProvider.notifier).toggleFavorite(booksData[index]);
                                                      });
                                                      ScaffoldMessenger.of(context).clearSnackBars();
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            ref.watch(favoriteBooksProvider.notifier).isClick(book)
                                                                ? 'The Book is removed from favorite'
                                                                : 'The Book is added to favorite',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
