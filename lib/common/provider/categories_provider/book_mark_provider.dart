import 'package:book_library/common/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tuple/tuple.dart';

final pagesBook = StateProvider<int>((ref) => 0);




// final bookMarkProvider = StateProvider.family<bool, Tuple3<bool, int, List>>(
//   (ref, tuple) {
//     final box = Hive.box('saveBox');
//     final key = 'bookmark_${tuple.item2}'; // Use a unique key based on the parameters
//     if (box.containsKey(key)) {
//       return box.get(key);
//     } else {
//       box.put(key, false);
//       return false;
//     }
//   },
// );

// void updateBookmarkState(Tuple3<bool, int, List> tuple, bool newValue) {
//   final box = Hive.box('saveBox');
//   final key = 'bookmark_${tuple.item2}'; // Use a unique key based on the parameters
//   box.put(key, newValue);
// }

// // final bookMarkProvider = StateProvider.family<bool, Tuple3<bool, int, List>>(
// //   (ref, tuple) => false,
// // );
