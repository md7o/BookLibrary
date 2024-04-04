import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/features/profile/widget/shelf.dart';
import 'package:book_library/features/account_sign/sign_up.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(
            child: Text('No Data found.'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        final userData = snapshot.data!;

        return Scaffold(
          backgroundColor: AppColors.bg1,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('Profile'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              const AnimationWall(),
              Column(
                children: [
                  const SizedBox(height: 50 * 2),
                  Column(
                    children: [
                      CircleAvatar(
                        maxRadius: 35,
                        backgroundColor: AppColors.bg2,
                        backgroundImage: NetworkImage(
                          userData['image_url'],
                        ),
                      ),
                      Text(
                        userData['username'],
                        style: const TextStyle(
                            fontSize: AppFontSize.large,
                            fontWeight: FontWeight.bold),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: Text(
                          userData['email'],
                          style: const TextStyle(fontSize: AppFontSize.small),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.large),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.bg2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            const InkWell(
                              // onTap: () {
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (context) => const AllBook(),
                              //     ),
                              //   );
                              // },
                              child: Shelf(
                                title: 'All Books',
                                iconContent: Icon(
                                  Icons.menu_book_rounded,
                                  size: 35,
                                  color: Colors.amber,
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
                                  color: Colors.green,
                                ),
                                arrowIcon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
