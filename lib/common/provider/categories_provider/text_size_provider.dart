import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final fontSizeProvider = StateProvider<double>((ref) {
  // Initialize the font size from Hive box
  final box = Hive.box('saveBox');
  return box.get('fontSize', defaultValue: 16.0);
});
