import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/account_sign/sign_up.dart';
import 'package:book_library/features/profile/all_book.dart';
import 'package:book_library/features/profile/widget/shelf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Pro extends StatelessWidget {
  const Pro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
        backgroundColor: AppColors.bg1,
      ),
      body: Expanded(
        child: Padding(
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AllBook(),
                        ),
                      );
                    },
                    child: const Shelf(
                      title: 'All Books',
                      iconContent: Icon(
                        Icons.menu_book_rounded,
                        size: 30,
                        color: Colors.amber,
                      ),
                      arrowIcon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                  const Divider(indent: 60),
                  const Shelf(
                    title: 'Favorite',
                    iconContent: Icon(
                      Icons.favorite_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                    arrowIcon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                  ),
                  const Divider(
                    indent: 60,
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
      ),
    );
  }
}
