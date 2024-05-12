import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationBottomShet extends StatefulWidget {
  const NotificationBottomShet({super.key});

  @override
  State<NotificationBottomShet> createState() => _NotificationBottomShetState();
}

class _NotificationBottomShetState extends State<NotificationBottomShet> {
  AnimationController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool switcher = false;

  bool showDatePicker = false;

  double _containerHeight = 0.0;
  bool isContentVisible = false;

  Widget cupertinoPicker() {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      initialDateTime: selectedTime,
      onDateTimeChanged: (DateTime newDate) {
        setState(
          () {
            selectedTime = newDate;
          },
        );
      },
      use24hFormat: false,
    );
  }

  DateTime selectedTime = DateTime.now();

  String displayTime = '';
  void updateDisplayTime() {
    final hours = selectedTime.hour % 12 == 0 ? 12 : selectedTime.hour % 12;
    final minutes = selectedTime.minute.toString().padLeft(2, '0');
    final ampm = selectedTime.hour >= 12 ? 'PM' : 'AM';
    setState(() {
      displayTime = "$hours:$minutes $ampm";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg2,
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Save',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancle',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: selectedTime,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  selectedTime = newDate;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
