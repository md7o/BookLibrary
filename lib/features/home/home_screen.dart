import 'package:book_library/common/enums/buttons_filter.dart';
import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/favorite_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/widgets/divider.dart';
import 'package:book_library/features/book_sound/book_content.dart';
import 'package:book_library/features/favorite/favorite_books.dart';
import 'package:book_library/features/home/search_engine.dart';
import 'package:book_library/features/home/widget/books_classes.dart';
import 'package:book_library/features/home/widget/categories_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late BookFilter selectedFilter;

  bool onChange = true;

  @override
  void initState() {
    super.initState();
    selectedFilter = BookFilter.all;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);
    final favoriteBooks = ref.watch(favoriteBooksProvider);

    return Scaffold(
      backgroundColor: AppColors.bg2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(color: AppColors.bg2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset.zero,
                          end: const Offset(0.0, -1),
                        ).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: Curves.easeIn,
                          ),
                        ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Text(
                            'Library',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Hero(
                          tag: "search_text_field",
                          child: Material(
                            child: SizedBox(
                              height: 35,
                              child: TextField(
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  isDense: true,
                                  filled: true,
                                  fillColor: AppColors.bg1,
                                  prefixIcon: const Icon(Icons.search),
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onTap: () {
                                  _controller.forward();
                                  Future.delayed(
                                    const Duration(milliseconds: 50),
                                    () {
                                      Navigator.of(context)
                                          .push(
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                          pageBuilder: (_, __, ___) =>
                                              RsearchEngine(),
                                        ),
                                      )
                                          .then(
                                        (result) {
                                          if (result == 'cancelled') {
                                            _controller.reverse();
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: onChange ? null : MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: AppColors.bg1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.medium),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                      child: CategoriesButtons(
                        onFilterChanged: (filter) {
                          setState(
                            () {
                              selectedFilter = filter;
                              if (selectedFilter == BookFilter.stories ||
                                  selectedFilter == BookFilter.fiction ||
                                  selectedFilter == BookFilter.historical) {
                                onChange = false;
                              } else {
                                onChange = true;
                              }
                            },
                          );
                        },
                      ),
                    ),
                    if (selectedFilter == BookFilter.all ||
                        selectedFilter == BookFilter.stories)
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppPadding.xlarge,
                                  bottom: AppPadding.small,
                                  top: AppPadding.medium),
                              child: Text(
                                "Stories",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            child: booksData.when(
                              data: (booksData) {
                                List<BooksModel> booksList =
                                    booksData.where((book) {
                                  return book.classification == 'Stories';
                                  // ignore: dead_code
                                  if (selectedFilter == BookFilter.stories ||
                                      selectedFilter == BookFilter.all) {
                                    return true;
                                  } else {
                                    return book.classification ==
                                        _filterToString(selectedFilter);
                                  }
                                }).toList();
                                return ListView.builder(
                                  itemCount: booksList.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    final book = booksList[index];

                                    return Hero(
                                      tag: index,
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          onTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => BookContent(
                                                  index: index,
                                                  cnt: booksList[index]),
                                            ),
                                          ),
                                          child: BooksClasses(
                                            title: "${booksList[index].title}",
                                            author:
                                                "${booksList[index].author}",
                                            price: "${booksList[index].price}",
                                            coverBook:
                                                "${booksList[index].coverbook}",
                                            favButton: () {
                                              ref
                                                  .watch(favoriteBooksProvider
                                                      .notifier)
                                                  .toggleFavorite(
                                                    booksList[index],
                                                  );
                                            },
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
                          const AppDivider(), //===============separator
                        ],
                      ),
                    if (selectedFilter == BookFilter.all ||
                        selectedFilter == BookFilter.fiction)
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppPadding.xlarge,
                                  bottom: AppPadding.small,
                                  top: AppPadding.medium),
                              child: Text(
                                "Fiction",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            child: booksData.when(
                              data: (booksData) {
                                List<BooksModel> booksList =
                                    booksData.where((book) {
                                  return book.classification == 'Fiction';
                                  // ignore: dead_code
                                  if (selectedFilter == BookFilter.fiction ||
                                      selectedFilter == BookFilter.all) {
                                    return true;
                                  } else {
                                    return book.classification ==
                                        _filterToString(selectedFilter);
                                  }
                                }).toList();
                                return ListView.builder(
                                  itemCount: booksList.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    return BooksClasses(
                                      title: "${booksList[index].title}",
                                      author: "${booksList[index].author}",
                                      price: "${booksList[index].price}",
                                      coverBook:
                                          "${booksList[index].coverbook}",
                                      favButton: () {
                                        booksData.add(booksList[index]);
                                      },
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
                          const AppDivider(), //===============separator
                        ],
                      ),
                    if (selectedFilter == BookFilter.all ||
                        selectedFilter == BookFilter.historical)
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppPadding.xlarge,
                                  bottom: AppPadding.small,
                                  top: AppPadding.medium),
                              child: Text(
                                "Historical",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            child: booksData.when(
                              data: (booksData) {
                                List<BooksModel> booksList =
                                    booksData.where((book) {
                                  return book.classification == 'Historical';
                                  // ignore: dead_code
                                  if (selectedFilter == BookFilter.historical ||
                                      selectedFilter == BookFilter.all) {
                                    return true;
                                  } else {
                                    return book.classification ==
                                        _filterToString(selectedFilter);
                                  }
                                }).toList();
                                return ListView.builder(
                                  itemCount: booksList.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    return BooksClasses(
                                      title: "${booksList[index].title}",
                                      author: "${booksList[index].author}",
                                      price: "${booksList[index].price}",
                                      coverBook:
                                          "${booksList[index].coverbook}",
                                      favButton: () {
                                        booksData.add(booksList[index]);
                                      },
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
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoriteBooks(),
              ),
            );
          },
          child: const Text('FavoritePage')),
    );
  }

  String _filterToString(BookFilter filter) {
    return filter.toString().split('.').last;
  }
}
