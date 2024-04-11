import 'package:book_library/common/provider/categories_provider/text_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TextSizeChanger extends ConsumerStatefulWidget {
  const TextSizeChanger({super.key});

  @override
  ConsumerState<TextSizeChanger> createState() => _TextSizeChangerState();
}

class _TextSizeChangerState extends ConsumerState<TextSizeChanger> {
  @override
  Widget build(BuildContext context) {
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Change Font Size',
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _saveFontSize(16.0);
                },
                child: Text('Small'),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveFontSize(20.0);
                },
                child: Text('Medium'),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveFontSize(24.0);
                },
                child: Text('Large'),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveFontSize(30.0);
                },
                child: Text('Extra Large'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveFontSize(double fontSize) async {
    final box = await Hive.openBox('saveBox');
    await box.put('fontSize', fontSize);
    ref.read(fontSizeProvider.notifier).state = fontSize; // Update font size immediately
  }
}
