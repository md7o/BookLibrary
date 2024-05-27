import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/account_sign/sign_up.dart';
import 'package:book_library/features/profile/categories_pages/book_theme.dart';
import 'package:book_library/features/profile/categories_pages/font_style.dart';
import 'package:book_library/features/profile/categories_pages/sources_content.dart';
import 'package:book_library/features/profile/widget/shelf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class TestSetting extends StatefulWidget {
  const TestSetting({super.key});

  @override
  State<TestSetting> createState() => _TestSettingState();
}

class _TestSettingState extends State<TestSetting> {
  final double iconShape = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          const AnimationWall(),
          ListView(
            children: [
              const SizedBox(height: 20),
              const Column(
                children: [
                  CircleAvatar(
                    maxRadius: 35,
                    backgroundColor: AppColors.bg2,
                    backgroundImage: NetworkImage(
                      "",
                    ),
                  ),
                  Text(
                    ' userData[]',
                    style: TextStyle(fontSize: AppFontSize.large, fontWeight: FontWeight.bold),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      'userData[]',
                      style: TextStyle(fontSize: AppFontSize.small),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
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
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //         builder: (context) => BookTheme(),
                        //       ),
                        //     );
                        //   },
                        //   child: Shelf(
                        //     title: 'Book Theme',
                        //     iconContent: Icon(
                        //       Icons.mode,
                        //       size: iconShape,
                        //     ),
                        //     arrowIcon: Icon(
                        //       Icons.arrow_forward_ios_rounded,
                        //       size: 20,
                        //     ),
                        //   ),
                        // ),
                        // const Opacity(
                        //   opacity: 0.4,
                        //   child: Divider(indent: 60),
                        // ),
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
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About',
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
                            arrowIcon: Icon(
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },
                          child: InkWell(
                            onTap: () async {
                              await Share.share(
                                  'World Cars includes many famous cars from 4 countries, America - Japan - Germany - South Korea. https://play.google.com/store/apps/details?id=com.world.cars.worldcars');
                            },
                            child: Shelf(
                              title: 'Share',
                              iconContent: Icon(
                                Icons.share,
                                size: iconShape,
                              ),
                              arrowIcon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const Opacity(
                          opacity: 0.4,
                          child: Divider(indent: 60),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },
                          child: Shelf(
                            title: 'Rate the app',
                            iconContent: Icon(
                              Icons.star,
                              size: iconShape,
                            ),
                            arrowIcon: Icon(
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },
                          child: Shelf(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                            },
                            title: 'LogOut',
                            iconContent: Icon(
                              Icons.logout,
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
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
