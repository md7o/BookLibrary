import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/setting/categories_pages/font_style.dart';
import 'package:book_library/features/setting/categories_pages/sources_content.dart';
import 'package:book_library/features/setting/widget/shelf.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingState();
}

class _SettingState extends State<SettingPage> with TickerProviderStateMixin {
  final double iconShape = 30.0;

  late AnimationController _controller;
  late Animation<double> _Animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this, value: 0);
    _Animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  bool anyBookFavored = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          const AnimationWall(),
          FadeTransition(
            opacity: _Animation,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Book options',
                      style: TextStyle(fontSize: 18, color: Colors.white60),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const EditFont(),
                                ),
                              );
                            },
                            child: Shelf(
                              title: 'Text Size',
                              iconContent: Icon(
                                Icons.text_fields_outlined,
                                size: iconShape,
                              ),
                              arrowIcon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // About categories ================
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SourcesContent(),
                                ),
                              );
                            },
                            child: Shelf(
                              title: 'Sources',
                              iconContent: Icon(
                                Icons.source_rounded,
                                size: iconShape,
                              ),
                              arrowIcon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              await Share.share(
                                  'Introducing [AppName]– your ultimate digital bookshelf. Discover, read, and organize your favorite books all in one place. With a vast library of titles across genres');
                            },
                            child: Shelf(
                              title: 'Share',
                              iconContent: Icon(
                                Icons.share,
                                size: iconShape,
                              ),
                              arrowIcon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                          const Opacity(
                            opacity: 0.4,
                            child: Divider(indent: 60),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Shelf(
                              title: 'Rate The App',
                              iconContent: Icon(
                                Icons.star,
                                size: iconShape,
                              ),
                              arrowIcon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
