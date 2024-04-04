import 'package:book_library/common/enums/buttons_filter.dart';
import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/favorite_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';

import 'package:book_library/features/book_sound/book_content.dart';
import 'package:book_library/features/home/search_engine.dart';

import 'package:book_library/features/home/widget/categories_buttons.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final boolStateProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  FocusNode focusNode = FocusNode();

  // bool isClick = false;

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

  // final _saveBox = Hive.box('saveBox');

// write data
  // writeData(List<BooksModel> booksList) async {
  //   _saveBox.put('booksList', booksList);
  // }

// read data
  void readData() {}
//delete data
  void deleteData() {}

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);
    final bool isAdded = ref.watch(boolStateProvider);

    return Scaffold(
      backgroundColor: AppColors.bg1,
      body: Stack(
        children: [
          const AnimationWall(),
          Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                child: Align(
                  alignment: Alignment.centerLeft,
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
                        'Home',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                child: Hero(
                  tag: "search_text_field",
                  child: Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                        keyboardType: TextInputType.none,
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
                        onTap: () {
                          FocusScope.of(context).autofocus(focusNode);
                          _controller.forward();
                          Future.delayed(
                            const Duration(milliseconds: 50),
                            () {
                              Navigator.of(context)
                                  .push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder: (_, __, ___) => RsearchEngine(),
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
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.xlarge, top: AppPadding.large),
                  child: Text(
                    "Recommended",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              booksData.when(
                data: (booksData) {
                  List<BooksModel> booksList = booksData.toList();

                  if (!onChange) {
                    booksList = booksList.where((book) {
                      if (selectedFilter == BookFilter.stories) {
                        return book.classification == "Stories";
                      } else if (selectedFilter == BookFilter.fiction) {
                        return book.classification == "Fiction";
                      } else if (selectedFilter == BookFilter.historical) {
                        return book.classification == "Historical";
                      }
                      return false;
                    }).toList();
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: booksList.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        final book = booksList[index];

                        return Hero(
                          tag: index,
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookContent(
                                    index: index,
                                    cnt: booksList[index],
                                  ),
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 180,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: AppPadding.xlarge),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // Image border

                                                child: Image.network(
                                                  book.coverbook.toString(),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            AppPadding.small),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          book.title.toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                        Opacity(
                                                          opacity: 0.8,
                                                          child: Text(
                                                            book.author
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                      icon: Icon(ref
                                                              .watch(
                                                                  favoriteBooksProvider
                                                                      .notifier)
                                                              .isClick(book)
                                                          ? Icons.bookmark
                                                          : Icons
                                                              .bookmark_outline),
                                                      onPressed: () {
                                                        setState(() {
                                                          ref
                                                              .watch(
                                                                  favoriteBooksProvider
                                                                      .notifier)
                                                              .toggleFavorite(
                                                                  booksList[
                                                                      index]);
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      book.classification
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

                                  // BooksClasses(
                                  //   title: "${book.title}",
                                  //   author: "${book.author}",
                                  //   classification:
                                  //       "Type: ${book.classification}",
                                  //   coverBook: "${book.coverbook}",
                                  //   child: IconButton(
                                  //     icon: isClick
                                  //         ? const Icon(
                                  //             Icons.bookmark_add,
                                  //             size: 30,
                                  //           )
                                  //         : const Icon(
                                  //             Icons.bookmark_outline,
                                  //             size: 30,
                                  //           ),
                                  //     onPressed: () {
                                  //       ref
                                  //           .watch(favoriteBooksProvider.notifier)
                                  //           .toggleFavorite(
                                  //             booksList[index],
                                  //           );
                                  //       setState(
                                  //         () {
                                  //           isClick = !isClick;
                                  //         },
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, s) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _filterToString(BookFilter filter) {
    return filter.toString().split('.').last;
  }
}
            // const Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: EdgeInsets.only(
            //         left: AppPadding.xlarge,
            //         bottom: AppPadding.small,
            //         top: AppPadding.medium),
            //     child: Text(
            //       "Stories",
            //       style:
            //           TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: onChange ? null : MediaQuery.of(context).size.height,
            //   decoration: const BoxDecoration(
            //     color: AppColors.bg1,
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(40),
            //       topRight: Radius.circular(40),
            //     ),
            //   ),
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: AppPadding.medium),
            //     child: Column(
            //       children: [
            //         SizedBox(
            //           height: 25,
            //           child: CategoriesButtons(
            //             onFilterChanged: (filter) {
            //               setState(
            //                 () {
            //                   selectedFilter = filter;
            //                   if (selectedFilter == BookFilter.stories ||
            //                       selectedFilter == BookFilter.fiction ||
            //                       selectedFilter == BookFilter.historical) {
            //                     onChange = false;
            //                   } else {
            //                     onChange = true;
            //                   }
            //                 },
            //               );
            //             },
            //           ),
            //         ),
            //         if (selectedFilter == BookFilter.all ||
            //             selectedFilter == BookFilter.stories)
            //           Column(
            //             children: [
            //               const Align(
            //                 alignment: Alignment.centerLeft,
            //                 child: Padding(
            //                   padding: EdgeInsets.only(
            //                       left: AppPadding.xlarge,
            //                       bottom: AppPadding.small,
            //                       top: AppPadding.medium),
            //                   child: Text(
            //                     "Stories",
            //                     style: TextStyle(
            //                         fontSize: 25, fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 160,
            //                 child: booksData.when(
            //                   data: (booksData) {
            //                     List<BooksModel> booksList =
            //                         booksData.where((book) {
            //                       return book.classification == 'Stories';
            //                       // ignore: dead_code
            //                       if (selectedFilter == BookFilter.stories ||
            //                           selectedFilter == BookFilter.all) {
            //                         return true;
            //                       } else {
            //                         return book.classification ==
            //                             _filterToString(selectedFilter);
            //                       }
            //                     }).toList();
            //                     return ListView.builder(
            //                       itemCount: booksList.length,
            //                       scrollDirection: Axis.horizontal,
            //                       shrinkWrap: true,
            //                       itemBuilder: (ctx, index) {
            //                         final book = booksList[index];

            //                         return Hero(
            //                           tag: index,
            //                           child: Material(
            //                             type: MaterialType.transparency,
            //                             child: InkWell(
            //                               onTap: () =>
            //                                   Navigator.of(context).push(
            //                                 MaterialPageRoute(
            //                                   builder: (context) => BookContent(
            //                                     index: index,
            //                                     cnt: booksList[index],
            //                                   ),
            //                                 ),
            //                               ),
            //                               child: BooksClasses(
            //                                 title: "${book.title}",
            //                                 author: "${book.author}",
            //                                 price: "${book.price}",
            //                                 coverBook: "${book.coverbook}",
            //                                 child: IconButton(
            //                                   icon: isClick
            //                                       ? const Icon(
            //                                           Icons.favorite,
            //                                           size: 30,
            //                                         )
            //                                       : const Icon(
            //                                           Icons.favorite_border,
            //                                           size: 30,
            //                                         ),
            //                                   onPressed: () {
            //                                     ref
            //                                         .watch(favoriteBooksProvider
            //                                             .notifier)
            //                                         .toggleFavorite(
            //                                           booksList[index],
            //                                         );
            //                                     setState(() {
            //                                       isClick = !isClick;
            //                                     });
            //                                   },
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         );
            //                       },
            //                     );
            //                   },
            //                   error: (error, s) => Text(error.toString()),
            //                   loading: () => const Center(
            //                     child: CircularProgressIndicator(),
            //                   ),
            //                 ),
            //               ),
            //               const AppDivider(), //===============separator
            //             ],
            //           ),
            //         if (selectedFilter == BookFilter.all ||
            //             selectedFilter == BookFilter.fiction)
            //           Column(
            //             children: [
            //               const Align(
            //                 alignment: Alignment.centerLeft,
            //                 child: Padding(
            //                   padding: EdgeInsets.only(
            //                       left: AppPadding.xlarge,
            //                       bottom: AppPadding.small,
            //                       top: AppPadding.medium),
            //                   child: Text(
            //                     "Fiction",
            //                     style: TextStyle(
            //                         fontSize: 25, fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 160,
            //                 child: booksData.when(
            //                   data: (booksData) {
            //                     List<BooksModel> booksList =
            //                         booksData.where((book) {
            //                       return book.classification == 'Fiction';
            //                       // ignore: dead_code
            //                       if (selectedFilter == BookFilter.fiction ||
            //                           selectedFilter == BookFilter.all) {
            //                         return true;
            //                       } else {
            //                         return book.classification ==
            //                             _filterToString(selectedFilter);
            //                       }
            //                     }).toList();
            //                     return ListView.builder(
            //                       itemCount: booksList.length,
            //                       scrollDirection: Axis.horizontal,
            //                       shrinkWrap: true,
            //                       itemBuilder: (ctx, index) {
            //                         return BooksClasses(
            //                           title: "${booksList[index].title}",
            //                           author: "${booksList[index].author}",
            //                           price: "${booksList[index].price}",
            //                           coverBook:
            //                               "${booksList[index].coverbook}",
            //                           child: IconButton(
            //                             icon: isClick
            //                                 ? const Icon(
            //                                     Icons.favorite,
            //                                     size: 30,
            //                                   )
            //                                 : const Icon(
            //                                     Icons.favorite_border,
            //                                     size: 30,
            //                                   ),
            //                             onPressed: () {
            //                               ref
            //                                   .watch(favoriteBooksProvider
            //                                       .notifier)
            //                                   .toggleFavorite(
            //                                     booksList[index],
            //                                   );
            //                               setState(() {
            //                                 isClick = !isClick;
            //                               });
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     );
            //                   },
            //                   error: (error, s) => Text(error.toString()),
            //                   loading: () => const Center(
            //                     child: CircularProgressIndicator(),
            //                   ),
            //                 ),
            //               ),
            //               const AppDivider(), //===============separator
            //             ],
            //           ),
            //         if (selectedFilter == BookFilter.all ||
            //             selectedFilter == BookFilter.historical)
            //           Column(
            //             children: [
            //               const Align(
            //                 alignment: Alignment.centerLeft,
            //                 child: Padding(
            //                   padding: EdgeInsets.only(
            //                       left: AppPadding.xlarge,
            //                       bottom: AppPadding.small,
            //                       top: AppPadding.medium),
            //                   child: Text(
            //                     "Historical",
            //                     style: TextStyle(
            //                         fontSize: 25, fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 160,
            //                 child: booksData.when(
            //                   data: (booksData) {
            //                     List<BooksModel> booksList =
            //                         booksData.where((book) {
            //                       return book.classification == 'Historical';
            //                       // ignore: dead_code
            //                       if (selectedFilter == BookFilter.historical ||
            //                           selectedFilter == BookFilter.all) {
            //                         return true;
            //                       } else {
            //                         return book.classification ==
            //                             _filterToString(selectedFilter);
            //                       }
            //                     }).toList();
            //                     return ListView.builder(
            //                       itemCount: booksList.length,
            //                       scrollDirection: Axis.horizontal,
            //                       shrinkWrap: true,
            //                       itemBuilder: (ctx, index) {
            //                         return BooksClasses(
            //                           title: "${booksList[index].title}",
            //                           author: "${booksList[index].author}",
            //                           price: "${booksList[index].price}",
            //                           coverBook:
            //                               "${booksList[index].coverbook}",
            //                           child: IconButton(
            //                             icon: isClick
            //                                 ? const Icon(
            //                                     Icons.favorite,
            //                                     size: 30,
            //                                   )
            //                                 : const Icon(
            //                                     Icons.favorite_border,
            //                                     size: 30,
            //                                   ),
            //                             onPressed: () {
            //                               ref
            //                                   .watch(favoriteBooksProvider
            //                                       .notifier)
            //                                   .toggleFavorite(
            //                                     booksList[index],
            //                                   );
            //                               setState(() {
            //                                 isClick = !isClick;
            //                               });
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     );
            //                   },
            //                   error: (error, s) => Text(error.toString()),
            //                   loading: () => const Center(
            //                     child: CircularProgressIndicator(),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //       ],
            //     ),
            //   ),
            // ),