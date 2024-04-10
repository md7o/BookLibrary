import 'package:book_library/common/enums/buttons_filter.dart';
import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/favorite_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/book_content.dart';
import 'package:book_library/features/home/search_engine.dart';
import 'package:book_library/features/home/widget/categories_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
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
    final favoriteBooks = ref.watch(favoriteBooksProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.bg1,
      body: Stack(
        children: [
          const AnimationWall(),
          Column(
            children: [
              const SizedBox(height: 50),
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
                      child: const Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 50,
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
              const Align(
                alignment: Alignment.centerLeft,
                heightFactor: 0.7,
                child: Padding(
                  padding: EdgeInsets.only(left: AppPadding.xlarge, top: AppPadding.xlarge),
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
                      physics: const BouncingScrollPhysics(),
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
                                                              icon: ref.watch(favoriteBooksProvider.notifier).isClick(book)
                                                                  ? const Icon(
                                                                      Icons.bookmark_rounded,
                                                                      size: 25,
                                                                    )
                                                                  : const Icon(
                                                                      Icons.bookmark_add_outlined,
                                                                      size: 25,
                                                                    ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  ref.watch(favoriteBooksProvider.notifier).toggleFavorite(book);
                                                                });
                                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  const SnackBar(
                                                                    content: Text('The Book is added to favorite'),
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
}
