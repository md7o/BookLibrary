import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tuple/tuple.dart';

final FavoProvider = StateProvider.family<bool, Tuple3<bool, int, List>>(
  (ref, tuple) {
    final box = Hive.box('saveBox');
    final key = 'bookfavo${tuple.item2}'; // Use a unique key based on the parameters
    if (box.containsKey(key)) {
      return box.get(key);
    } else {
      box.put(key, false);
      return false;
    }
  },
);

void updateBookmarkState(Tuple3<bool, int, List> tuple, bool newValue) {
  final box = Hive.box('saveBox');
  final key = 'bookfavo${tuple.item2}'; // Use a unique key based on the parameters
  box.put(key, newValue);
}
