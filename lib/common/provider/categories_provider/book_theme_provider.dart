import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final containerColorProvider = StateNotifierProvider<ColorNotifier, Color>((ref) {
  return ColorNotifier(Colors.blue); // Initial color for the container
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
    final selectedColorValue = box.get('selectedColor', defaultValue: Colors.blue.value);
    state = Color(selectedColorValue);
  }
}


// final containerColorProvider = StateNotifierProvider<ColorNotifier, Color>((ref) {
//   return ColorNotifier(Colors.blue); // Initial color for the container
// });

// class ColorNotifier extends StateNotifier<Color> {
//   ColorNotifier(Color state) : super(state);

//   void changeColor(Color newColor) {
//     state = newColor;
//   }
// }
