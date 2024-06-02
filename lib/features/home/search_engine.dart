import 'dart:math';

import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/favorite_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/book_content/book_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchEngine extends ConsumerStatefulWidget {
  const SearchEngine({super.key});

  @override
  ConsumerState<SearchEngine> createState() => _SearchEngine();
}

final TextEditingController _searchController = TextEditingController();

class _SearchEngine extends ConsumerState<SearchEngine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

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
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Material(
                color: Colors.transparent,
                type: MaterialType.transparency,
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    autofocus: true,
                    controller: _searchController,
                    onChanged: (value) => ref.refresh(
                      booksContentProvider,
                    ),
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
        ),
        actions: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                ).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context, 'cancelled');
                      _searchController.clear();
                      _controller.reverse();
                      // ref.refresh(booksContentProvider); // Refresh the book list
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          child: booksData.when(
            data: (booksData) {
              // Random randomizeList = Random(1);
              // filteredBooks.shuffle(randomizeList);

              return ListView.builder(
                itemCount: filteredBooks.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  final book = filteredBooks[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BookDetails(
                                index: index,
                                cnt: book,
                              );
                            },
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 2),
                                end: const Offset(0, 0),
                              ).animate(
                                CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Hero(
                                                  tag: index,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(3), // Image border

                                                      child: Image.asset(
                                                        book.coverbook.toString(),
                                                      ),
                                                    ),
                                                  ),
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
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(context).size.height <= 700 ? 15 : 18,
                                                            ),
                                                          ),
                                                          Opacity(
                                                            opacity: 0.8,
                                                            child: Text(
                                                              book.author.toString(),
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(context).size.height <= 700 ? 13 : 15,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 1),
                                                          Opacity(
                                                            opacity: 0.5,
                                                            child: Text(
                                                              book.classification.toString(),
                                                              style: const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    pageBuilder: (context, animation, secondaryAnimation) {
                                                      return BookDetails(
                                                        // transitionAnimation: animation,
                                                        index: index,
                                                        cnt: book,
                                                      );
                                                    },
                                                    transitionDuration: const Duration(milliseconds: 400),
                                                    reverseTransitionDuration: const Duration(milliseconds: 500),
                                                  ),
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                minimumSize: Size.zero,
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                                                foregroundColor: Colors.white,
                                                backgroundColor: AppColors.bg2,
                                              ),
                                              child: Text(
                                                "Read",
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height <= 700 ? 10 : 15,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Opacity(
                                      opacity: 0.4,
                                      child: Divider(
                                        indent: 100,
                                        endIndent: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
