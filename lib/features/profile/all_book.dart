// import 'package:book_library/common/enums/buttons_filter.dart';
// import 'package:book_library/common/models/book_model.dart';
// import 'package:book_library/common/provider/books_content_provider.dart';
// import 'package:book_library/common/provider/favorite_provider.dart';
// import 'package:book_library/common/src/constants/colors.dart';
// import 'package:book_library/common/src/constants/padding.dart';
// import 'package:book_library/common/src/widgets/divider.dart';
// import 'package:book_library/features/book_sound/book_content.dart';
// import 'package:book_library/features/favorite/favorite_books.dart';
// import 'package:book_library/features/home/widget/books_classes.dart';
// import 'package:book_library/features/home/widget/categories_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AllBook extends ConsumerStatefulWidget {
//   const AllBook({super.key});

//   @override
//   ConsumerState<AllBook> createState() => _AllBookState();
// }

// class _AllBookState extends ConsumerState<AllBook> {
//   late BookFilter selectedFilter;

//   bool onChange = true;

//   @override
//   void initState() {
//     super.initState();
//     // Set a default filter
//     selectedFilter = BookFilter.all;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final booksData = ref.watch(booksContentProvider);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.bg1,
//       ),
//       backgroundColor: AppColors.bg1,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: AppPadding.medium),
//               child: Column(
//                 children: [
//                   SizedBox(
//                       height: 25,
//                       child: CategoriesButtons(
//                         onFilterChanged: (filter) {
//                           setState(() {
//                             selectedFilter = filter;
//                             if (selectedFilter == BookFilter.stories ||
//                                 selectedFilter == BookFilter.fiction ||
//                                 selectedFilter == BookFilter.historical) {
//                               onChange = false;
//                             } else {
//                               onChange = true;
//                             }
//                           });
//                         },
//                       )),
//                   if (selectedFilter == BookFilter.all ||
//                       selectedFilter == BookFilter.stories)
//                     Column(
//                       children: [
//                         const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: AppPadding.xlarge,
//                                 bottom: AppPadding.small,
//                                 top: AppPadding.medium),
//                             child: Text(
//                               "Stories",
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 160,
//                           child: booksData.when(
//                             data: (booksData) {
//                               List<BooksModel> booksList =
//                                   booksData.where((book) {
//                                 return book.classification == 'Stories';
//                                 // ignore: dead_code
//                                 if (selectedFilter == BookFilter.stories ||
//                                     selectedFilter == BookFilter.all) {
//                                   return true;
//                                 } else {
//                                   return book.classification ==
//                                       _filterToString(selectedFilter);
//                                 }
//                               }).toList();
//                               // book.classification == 'Stories'
//                               return ListView.builder(
//                                 itemCount: booksList.length,
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 itemBuilder: (ctx, index) {
//                                   final book = booksList[index];

//                                   return Hero(
//                                     tag: index,
//                                     child: Material(
//                                       type: MaterialType.transparency,
//                                       child: InkWell(
//                                         onTap: () => Navigator.of(context)
//                                             .push(MaterialPageRoute(
//                                           builder: (context) => BookContent(
//                                               index: index,
//                                               cnt: booksList[index]),
//                                         )),
//                                         child: BooksClasses(
//                                           title: "${booksList[index].title}",
//                                           author: "${booksList[index].author}",
//                                           price: "${booksList[index].price}",
//                                           coverBook:
//                                               "${booksList[index].coverbook}",
//                                           favButton: () {
//                                             ref
//                                                 .read(selectedBookIndexProvider)
//                                                 !.state = index;
//                                             Navigator.of(context)
//                                                 .push(MaterialPageRoute(
//                                               builder: (context) =>
//                                                   FavoritePage(),
//                                             ));
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             error: (error, s) => Text(error.toString()),
//                             loading: () => const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                         ),
//                         const AppDivider(), //===============separator
//                       ],
//                     ),
//                   if (selectedFilter == BookFilter.all ||
//                       selectedFilter == BookFilter.fiction)
//                     Column(
//                       children: [
//                         const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: AppPadding.xlarge,
//                                 bottom: AppPadding.small,
//                                 top: AppPadding.medium),
//                             child: Text(
//                               "Fiction",
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 160,
//                           child: booksData.when(
//                             data: (booksData) {
//                               List<BooksModel> booksList =
//                                   booksData.where((book) {
//                                 return book.classification == 'Fiction';
//                                 // ignore: dead_code
//                                 if (selectedFilter == BookFilter.fiction ||
//                                     selectedFilter == BookFilter.all) {
//                                   return true;
//                                 } else {
//                                   return book.classification ==
//                                       _filterToString(selectedFilter);
//                                 }
//                               }).toList();
//                               return ListView.builder(
//                                 itemCount: booksList.length,
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 itemBuilder: (ctx, index) {
//                                   return BooksClasses(
//                                     title: "${booksList[index].title}",
//                                     author: "${booksList[index].author}",
//                                     price: "${booksList[index].price}",
//                                     coverBook: "${booksList[index].coverbook}",
//                                     favButton: () {
//                                       booksData.add(booksList[index]);
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                             error: (error, s) => Text(error.toString()),
//                             loading: () => const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                         ),
//                         const AppDivider(), //===============separator
//                       ],
//                     ),
//                   if (selectedFilter == BookFilter.all ||
//                       selectedFilter == BookFilter.historical)
//                     Column(
//                       children: [
//                         const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: AppPadding.xlarge,
//                                 bottom: AppPadding.small,
//                                 top: AppPadding.medium),
//                             child: Text(
//                               "Historical",
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 160,
//                           child: booksData.when(
//                             data: (booksData) {
//                               List<BooksModel> booksList =
//                                   booksData.where((book) {
//                                 return book.classification == 'Historical';
//                                 // ignore: dead_code
//                                 if (selectedFilter == BookFilter.historical ||
//                                     selectedFilter == BookFilter.all) {
//                                   return true;
//                                 } else {
//                                   return book.classification ==
//                                       _filterToString(selectedFilter);
//                                 }
//                               }).toList();
//                               return ListView.builder(
//                                 itemCount: booksList.length,
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 itemBuilder: (ctx, index) {
//                                   return 
//                                   BooksClasses(
//                                     title: "${booksList[index].title}",
//                                     author: "${booksList[index].author}",
//                                     price: "${booksList[index].price}",
//                                     coverBook: "${booksList[index].coverbook}",
//                                     favButton: () {
//                                       booksData.add(booksList[index]);
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                             error: (error, s) => Text(error.toString()),
//                             loading: () => const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton.extended(
//       //     onPressed: () {
//       //       Navigator.of(context).push(
//       //         MaterialPageRoute(
//       //           builder: (context) => const FavoriteBooks(),
//       //         ),
//       //       );
//       //     },
//       //     label: const Text('FavoritePage')),
//     );
//   }

//   String _filterToString(BookFilter filter) {
//     return filter.toString().split('.').last;
//   }
// }
