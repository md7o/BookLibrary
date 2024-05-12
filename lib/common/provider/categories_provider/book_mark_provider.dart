import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final bookMarkProvider = StateProvider.family<bool, Tuple3<bool, List, int>>(
  (ref, tuple) => false,
);
