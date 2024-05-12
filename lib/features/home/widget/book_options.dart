import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/home/widget/book_options_pages/random_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookOptions extends ConsumerStatefulWidget {
  const BookOptions({super.key});

  @override
  ConsumerState<BookOptions> createState() => _BookOptionsState();
}

class _BookOptionsState extends ConsumerState<BookOptions> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final booksData = ref.watch(booksContentProvider);

    bool isScreenSmall = MediaQuery.of(context).size.width <= 430;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
      child: Flex(
        direction: isScreenSmall ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RandomBook(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bg2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Random Book',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/images/add.png',
                      scale: 4,
                    )
                  ],
                ),
              ),
            ),
          ),
          isScreenSmall ? const SizedBox(height: 10) : const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.bg2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create a Book',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/images/shuffle.png',
                    scale: 4,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:book_library/common/models/book_model.dart';
// import 'package:book_library/common/provider/books_content_provider.dart';
// import 'package:book_library/common/src/constants/colors.dart';
// import 'package:book_library/common/src/constants/padding.dart';
// import 'package:book_library/features/book_content/ss.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class BookOptions extends ConsumerWidget {
//   const BookOptions({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final booksData = ref.watch(booksContentProvider);
//     bool isScreenSmall = MediaQuery.of(context).size.width <= 430;

//     return booksData.when(
//       data: (booksData) {
//         List<BooksModel> booksList = booksData.toList();
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
//           child: Flex(
//             direction: isScreenSmall ? Axis.vertical : Axis.horizontal,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ListView.builder(
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation, secondaryAnimation) {
//                             return ss(
//                               transitionAnimation: animation,
//                               index: index,
//                               cnt: booksList[index],
//                             );
//                           },
//                           transitionDuration: const Duration(milliseconds: 400),
//                           reverseTransitionDuration: const Duration(milliseconds: 500),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.bg2,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Random Book',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                             const SizedBox(width: 10),
//                             Image.asset(
//                               'assets/images/add.png',
//                               scale: 4,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               isScreenSmall ? const SizedBox(height: 10) : const SizedBox(width: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.bg2,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Create a Book',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       const SizedBox(width: 10),
//                       Image.asset(
//                         'assets/images/shuffle.png',
//                         scale: 4,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//       error: (error, s) => Text(error.toString()),
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }