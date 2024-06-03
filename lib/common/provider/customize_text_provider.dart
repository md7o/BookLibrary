import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final isBoldProvider = StateNotifierProvider<IsBoldNotifier, bool>((ref) {
  return IsBoldNotifier();
});

class IsBoldNotifier extends StateNotifier<bool> {
  IsBoldNotifier() : super(Hive.box('saveBox').get('isBold', defaultValue: false));

  void toggleBold(bool newValue) {
    state = newValue;
    Hive.box('saveBox').put('isBold', newValue);
  }
}

final isJustifyProvider = StateNotifierProvider<IsJustifyNotifier, bool>((ref) {
  return IsJustifyNotifier();
});

class IsJustifyNotifier extends StateNotifier<bool> {
  IsJustifyNotifier() : super(Hive.box('saveBox').get('isJustify', defaultValue: false));

  void toggleBold(bool newValue) {
    state = newValue;
    Hive.box('saveBox').put('isJustify', newValue);
  }
}
