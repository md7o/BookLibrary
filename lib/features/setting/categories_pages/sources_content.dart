import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:flutter/material.dart';

class SourcesContent extends StatelessWidget {
  const SourcesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        title: const Text('Sources'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const AnimationWall(),
          Column(
            children: [
              const SizedBox(height: 120),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'All sources are taken from Artificial Intelligence',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Books content Source',
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ChatGPT.png',
                    scale: 12,
                  ),
                  const SizedBox(width: 30),
                  Image.asset(
                    'assets/images/Gemini.png',
                    scale: 8,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                'Covers Books Source',
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/SeaArt.png',
                    scale: 12,
                  ),
                  const SizedBox(width: 40),
                  Image.asset(
                    'assets/images/Copilot.png',
                    scale: 4.5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
