import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClockNumbers {
  final int hours;
  final int minutes;
  final int seconds;

  ClockNumbers({required this.hours, required this.minutes, required this.seconds});

  @override
  String toString() {
    return '$hours hours $minutes minutes $seconds seconds';
  }
}

final screenTimeProvider = StateProvider<ClockNumbers>((ref) => ClockNumbers(hours: 0, minutes: 0, seconds: 0));
