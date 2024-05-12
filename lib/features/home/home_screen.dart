import 'dart:math';
import 'package:book_library/common/enums/buttons_filter.dart';
import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/categories_provider/book_mark_provider.dart';
import 'package:book_library/common/provider/favorite_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/ss.dart';
import 'package:book_library/features/home/search_engine.dart';
import 'package:book_library/features/home/widget/book_options.dart';
import 'package:book_library/features/home/widget/card_slider.dart';
import 'package:book_library/features/home/widget/categories_buttons.dart';
import 'package:book_library/features/home/widget/information_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  FocusNode focusNode = FocusNode();

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
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);
    // final bool isBookmarked = ref.watch(BookMarkProvider(currentIndex).notifier).state;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: 0.1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
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
                      child: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height <= 700 ? 40 : 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
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
                                  transitionDuration: const Duration(milliseconds: 500),
                                  pageBuilder: (_, __, ___) => const SearchEngine(),
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
              const SizedBox(height: 20),
              const InformationSlider(),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                heightFactor: 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(left: AppPadding.medium, top: AppPadding.medium, bottom: AppPadding.xlarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Book Content",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.height <= 700 ? 18 : 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Steps to create content from AI",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height <= 700 ? 18 : 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CardSlider(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.medium, bottom: 15),
                child: Text(
                  "Book Options",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height <= 700 ? 18 : 25,
                  ),
                ),
              ),
              const BookOptions(),
              const Align(
                alignment: Alignment.centerLeft,
                heightFactor: 0.7,
                child: Padding(
                  padding: EdgeInsets.only(left: AppPadding.medium, top: AppPadding.xlarge, bottom: AppPadding.xlarge),
                  child: Text(
                    "Recommended",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                        if (selectedFilter == BookFilter.stories || selectedFilter == BookFilter.fiction || selectedFilter == BookFilter.historical) {
                          onChange = false;
                        } else {
                          onChange = true;
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
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

                  Random random = Random();

                  booksList.shuffle(random);
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
                    itemCount: booksList.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      final book = booksList[index];

                      return Hero(
                        tag: index,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return ss(
                                      index: index,
                                      cnt: booksList[index],
                                    );
                                  },
                                  transitionDuration: const Duration(milliseconds: 400),
                                  reverseTransitionDuration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      book.coverbook.toString(),
                                      // fit: BoxFit.cover,
                                      scale: 0.1,
                                    ),
                                  ),
                                ),
                                // if (isBookmarked == true)
                                const Icon(Icons.bookmark),
                                const SizedBox(height: 10),
                                Text(
                                  book.title.toString(),
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height <= 700 ? 15 : 17,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.7,
                                  child: Text(
                                    book.author.toString(),
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height <= 700 ? 13 : 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // IconButton(
                                //   icon: ref.watch(favoriteBooksProvider.notifier).isClick(book)
                                //       ? const Icon(
                                //           Icons.bookmark_rounded,
                                //           size: 25,
                                //         )
                                //       : const Icon(
                                //           Icons.bookmark_add_outlined,
                                //           size: 25,
                                //         ),
                                //   onPressed: () {
                                //     setState(() {
                                //       ref.watch(favoriteBooksProvider.notifier).toggleFavorite(book);
                                //     });
                                //     ScaffoldMessenger.of(context).clearSnackBars();
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(
                                //         content: Text('The Book is added to favorite'),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ],
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
            ],
          ),
        ],
      ),
    );
  }
}

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
