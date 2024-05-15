import 'dart:async';

import 'package:book_library/common/provider/categories_provider/screen_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenTime extends ConsumerStatefulWidget {
  const ScreenTime({super.key});

  @override
  ConsumerState<ScreenTime> createState() => _ScreenTimeState();
}

class _ScreenTimeState extends ConsumerState<ScreenTime> {
  @override
  Widget build(BuildContext context) {
    // final screenTimeBox = Hive.box('saveBox');
    // final screenTime = screenTimeBox.get('clock_numbers', defaultValue: ClockNumbers(hours: 0, minutes: 0, seconds: 0));

    final screenTime = ref.watch(screenTimeProvider.notifier).state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Text(
          'Screen Time from First Page: $screenTime seconds',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
