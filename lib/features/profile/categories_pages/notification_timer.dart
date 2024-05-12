import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/profile/categories_pages/notification/bottom_shet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationTimer extends StatefulWidget {
  const NotificationTimer({super.key});

  @override
  State<NotificationTimer> createState() => _NotifacctionTimerState();
}

class _NotifacctionTimerState extends State<NotificationTimer> {
  AnimationController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool switcher = false;

  void _openSettingContent() {
    showModalBottomSheet(
        transitionAnimationController: _controller,
        context: context,
        backgroundColor: Colors.transparent,
        elevation: 0,
        isScrollControlled: true,
        builder: (context) {
          return const FractionallySizedBox(
            heightFactor: 0.3,
            child: NotificationBottomShet(),
          );
        });
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

  bool showDatePicker = false;
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('kk:mm').format(selectedTime);

    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Notifaction'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enable Notification',
                  style: TextStyle(fontSize: 20),
                ),
                if (switcher = switcher)
                  InkWell(
                    onTap: _openSettingContent,
                    child: Container(
                      width: 80,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.bg2),
                      child: Center(
                        child: Text(
                          formattedDate.toString(),
                        ),
                      ),
                    ),
                  ),
                Switch.adaptive(
                  value: switcher,
                  onChanged: (value) {
                    setState(() {
                      switcher = value;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),

          //   Expanded(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
          //       child: Column(
          //         children: [
          //           const Text(
          //             'Timer',
          //             style: TextStyle(fontSize: 20),
          //           ),
          //           InkWell(
          //             highlightColor: Colors.transparent,
          //             onTap: () {
          //               setState(() {
          //                 setState(() {
          //                   _containerHeight = _containerHeight == 0 ? 150.0 : 0.0;
          //                 });
          //                 isContentVisible = !isContentVisible;
          //                 if (isContentVisible) {
          //                   _controller?.forward();
          //                 } else {
          //                   _controller?.reverse();
          //                 }
          //               });
          //             },
          //             child: Container(
          //               width: 80,
          //               height: 35,
          //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.bg2),
          //               child: Center(
          //                 child: Text(
          //                   showDatePicker ? displayTime : displayTime,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           AnimatedContainer(
          //             duration: const Duration(milliseconds: 500),
          //             curve: Curves.easeInOut,
          //             width: double.infinity,
          //             height: _containerHeight,
          //             alignment: Alignment.center,
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 10.0),
          //               child: cupertinoPicker(),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   )
        ],
      ),
    );
  }
}
