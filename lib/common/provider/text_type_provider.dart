import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final fontTypeProvider = StateProvider<int>((ref) {
  final box = Hive.box('saveBox');
  final savedFontType = box.get('fontType', defaultValue: 0) as int;
  return savedFontType;
});
