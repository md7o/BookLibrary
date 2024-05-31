import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/book_content/texts_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteBooks extends ConsumerStatefulWidget {
  const FavoriteBooks({super.key});

  @override
  ConsumerState<FavoriteBooks> createState() => _FavoriteBooksState();
}

class _FavoriteBooksState extends ConsumerState<FavoriteBooks> {
  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(booksContentProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Favorite'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          booksData.when(
            data: (booksData) {
              List<BooksModel> booksList = booksData.toList();

              // Track if any books are bookmarked
              bool anyBookmarked = false;

              List<Widget> favoriteBooks = [];
              for (var index = 0; index < booksList.length; index++) {
                final book = booksList[index];
                final box = Hive.box('saveBox');
                final key = 'bookfavorite_${book.title}_${book.id}';
                final isBookfavorite = box.get(key, defaultValue: false);

                anyBookmarked = true;
                favoriteBooks.add(
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TextsBooks(
                              character: book,
                            );
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        if (isBookfavorite)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
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
                                                type: MaterialType.transparency,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(3),
                                                  child: Image.network(
                                                    book.coverbook.toString(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.small),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    book.title ?? 'Unknown Title',
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.height <= 700 ? 15 : 18,
                                                    ),
                                                  ),
                                                  Opacity(
                                                    opacity: 0.8,
                                                    child: Text(
                                                      book.author ?? 'Unknown Author',
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(context).size.height <= 700 ? 13 : 15,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
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
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              box.put(key, !isBookfavorite);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.delete_forever_rounded,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     isBookfavorite = !isBookfavorite;
                                        //   },
                                        //   child: Icon(isBookfavorite ? Icons.favorite : Icons.favorite_border_outlined),
                                        // ),
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
                      ],
                    ),
                  ),
                );
              }

              if (!anyBookmarked) {
                return Center(
                  child: Text('There are no bookmarked books'),
                );
              }

              return ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: favoriteBooks,
              );
            },
            error: (error, s) => Text(error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:book_library/common/src/constants/padding.dart';
// import 'package:book_library/common/src/wallpaper/animation_wall.dart';
// import 'package:book_library/features/book_content/book_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:book_library/common/provider/favorite_provider.dart';

// class FavoriteBooks extends ConsumerStatefulWidget {
//   const FavoriteBooks({super.key});

//   @override
//   ConsumerState<FavoriteBooks> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<FavoriteBooks> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     final favoriteBooks = ref.watch(favoriteBooksProvider);

//     if (favoriteBooks.isEmpty) {
//       return Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           title: Text('Favorite Books'),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         body: const Stack(
//           children: [
//             AnimationWall(),
//             Center(child: Text('No favorite books yet.')),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text('Favorite Books'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: Stack(
//         children: [
//           const AnimationWall(),
//           Column(
//             children: [
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: favoriteBooks.length,
//                   itemBuilder: (context, index) {
//                     final book = favoriteBooks[index];
//                     return InkWell(
//                       onTap: () => Navigator.of(context).push(
//                         PageRouteBuilder(
//                             pageBuilder: (context, animation, secondaryAnimation) {
//                               return BookDetails(
//                                 index: index, // Assuming index is defined somewhere
//                                 cnt: favoriteBooks[index], // Assuming booksList is defined somewhere
//                               );
//                             },
//                             transitionDuration: const Duration(milliseconds: 800)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 15),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 100,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Hero(
//                                           tag: index,
//                                           child: Material(
//                                             type: MaterialType.transparency,
//                                             child: ClipRRect(
//                                               borderRadius: BorderRadius.circular(3), // Image border

//                                               child: Image.network(
//                                                 book.coverbook.toString(),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: AppPadding.small),
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     book.title ?? 'Unknown Title',
//                                                     style: TextStyle(
//                                                       fontSize: MediaQuery.of(context).size.height <= 700 ? 15 : 18,
//                                                     ),
//                                                   ),
//                                                   Opacity(
//                                                     opacity: 0.8,
//                                                     child: Text(
//                                                       book.author ?? 'Unknown Author',
//                                                       style: TextStyle(
//                                                         fontSize: MediaQuery.of(context).size.height <= 700 ? 13 : 15,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 1),
//                                                   Opacity(
//                                                     opacity: 0.5,
//                                                     child: Text(
//                                                       book.classification.toString(),
//                                                       style: const TextStyle(
//                                                         fontSize: 15,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.bookmark_remove_rounded,
//                                         size: 30,
//                                         color: Colors.redAccent,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           ref.watch(favoriteBooksProvider.notifier).toggleFavorite(book);
//                                         });
//                                         ScaffoldMessenger.of(context).clearSnackBars();
//                                         ScaffoldMessenger.of(context).showSnackBar(
//                                           const SnackBar(
//                                             content: Text('The Book is removed from favorite'),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const Opacity(
//                               opacity: 0.4,
//                               child: Divider(
//                                 indent: 100,
//                                 endIndent: 10,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
