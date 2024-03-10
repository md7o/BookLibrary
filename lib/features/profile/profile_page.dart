import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/profile/all_book.dart';
import 'package:book_library/features/profile/widget/shelf.dart';
import 'package:book_library/features/signup/sign_up.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Jude Bellingham',
                        style: TextStyle(
                            fontSize: AppFontSize.large,
                            fontWeight: FontWeight.bold),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: Text(
                          'md7ohe@gmail.com',
                          style: TextStyle(fontSize: AppFontSize.small),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7,
                      )
                    ],
                  ),
                  child: const CircleAvatar(
                    maxRadius: 35,
                    backgroundImage: NetworkImage(
                      'https://i.le360.ma/le360sport/sites/default/files/styles/img_738_520/public/assets/images/2023/10-reda/jude_bellingham.jpeg',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppFontSize.xlarge),
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
                    child: const Shelf(
                      title: 'SignIn',
                      iconContent: Icon(
                        Icons.login,
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
  }
}
