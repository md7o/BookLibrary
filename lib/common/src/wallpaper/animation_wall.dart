import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/wallpaper/shapes/CustomShapePainter.dart';

import 'package:flutter/material.dart';

class AnimationWall extends StatefulWidget {
  const AnimationWall({super.key});

  @override
  State<AnimationWall> createState() => _AnimationWallState();
}

class _AnimationWallState extends State<AnimationWall> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Use easeInOut curve
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      body: Center(
        child: Opacity(
          opacity: 0.1,
          child: CustomPaint(
            size: const Size(200, 200),
            painter: MyPainter(animationValue: _animation.value),
          ),
        ),
      ),
    );
  }
}
