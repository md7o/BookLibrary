import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/account_sign/sign_up.dart';
import 'package:book_library/features/profile/categories_pages/text_size_changer.dart';
import 'package:book_library/features/profile/widget/shelf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestSetting extends StatefulWidget {
  const TestSetting({super.key});

  @override
  State<TestSetting> createState() => _TestSettingState();
}

class _TestSettingState extends State<TestSetting> {
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
                    'General',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.bg2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const Shelf(
                          title: 'Notifaction',
                          iconContent: Icon(
                            Icons.notifications,
                            size: 35,
                            color: Colors.yellow,
                          ),
                          arrowIcon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ),
                        const Opacity(
                          opacity: 0.4,
                          child: Divider(indent: 60),
                        ),
                        const Shelf(
                          title: 'Favorite',
                          iconContent: Icon(
                            Icons.favorite_rounded,
                            size: 35,
                            color: Colors.red,
                          ),
                          arrowIcon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
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
                                builder: (context) => const TextSizeChanger(),
                              ),
                            );
                          },
                          child: const Shelf(
                            title: 'Text Size',
                            iconContent: Icon(
                              Icons.text_fields_outlined,
                              size: 35,
                              color: Colors.blue,
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
                        const Shelf(
                          title: 'Text Language',
                          iconContent: Icon(
                            Icons.font_download_rounded,
                            size: 35,
                            color: Colors.limeAccent,
                          ),
                          arrowIcon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
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
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.bg2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const Shelf(
                          title: 'Sources',
                          iconContent: Icon(
                            Icons.source_rounded,
                            size: 35,
                            color: Color(0xFFFFC800),
                          ),
                          arrowIcon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
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
                            title: 'Share',
                            iconContent: const Icon(
                              Icons.share,
                              size: 35,
                              color: Colors.greenAccent,
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
                            iconContent: const Icon(
                              Icons.logout,
                              size: 35,
                              color: Colors.red,
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
