import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/account_sign/sign_in.dart';
import 'package:book_library/features/profile/all_book.dart';
import 'package:book_library/features/profile/widget/shelf.dart';
import 'package:book_library/features/account_sign/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Data found.'),
              TextButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: Text("LogOut"))
            ],
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        final userData = snapshot.data!.docs;

        // return ListView.builder(
        //   itemCount: userData.length,
        //   itemBuilder: (ctx, index) => Text(userData[index].data()['email']),
        // );

        return Scaffold(
          backgroundColor: AppColors.bg1,
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Profile'),
              backgroundColor: AppColors.bg1),
          body: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: AppPadding.large),
                    child: Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                          color: AppColors.bg2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          Expanded(
                            child: ListView.builder(
                              itemCount: userData.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    // CircleAvatar(
                                    //   maxRadius: 35,
                                    //   backgroundColor: AppColors.bg2,
                                    //   backgroundImage: NetworkImage(
                                    //     userData[index].data()['image_url'],
                                    //   ),
                                    // ),
                                    Text(
                                      userData[index].data()['username'],
                                      style: const TextStyle(
                                          fontSize: AppFontSize.large,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Opacity(
                                      opacity: 0.6,
                                      child: Text(
                                        userData[index].data()['email'],
                                        style: const TextStyle(
                                            fontSize: AppFontSize.small),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: userData.length,
                        itemBuilder: (ctx, index) {
                          return Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7,
                                  )
                                ],
                              ),
                              child: CircleAvatar(
                                maxRadius: 35,
                                backgroundImage: NetworkImage(
                                  userData[index].data()['image_url'],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppFontSize.xlarge),
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AllBook(),
                          ));
                        },
                        child: const Shelf(
                          title: 'All Books',
                          iconContent: Icon(
                            Icons.menu_book_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(),
                      ),
                      const Shelf(
                        title: 'Favorite',
                        iconContent: Icon(
                          Icons.favorite_rounded,
                          size: 30,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(),
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
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
