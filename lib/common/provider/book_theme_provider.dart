import 'package:book_library/common/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final containerColorProvider = StateNotifierProvider<ColorNotifier, Color>((ref) {
  return ColorNotifier(AppColors.bg1);
});

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier(Color state) : super(state);

  Future<void> changeColor(Color newColor) async {
    final box = await Hive.openBox('saveBox');
    await box.put('selectedColor', newColor.value);
    state = newColor;
  }

  Future<void> loadSavedColor() async {
    final box = await Hive.openBox('saveBox');
    final selectedColorValue = box.get('selectedColor', defaultValue: AppColors.bg1.value);
    state = Color(selectedColorValue);
  }
}
