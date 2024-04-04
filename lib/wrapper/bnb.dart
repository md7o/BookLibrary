import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/features/favorite/favorite_books.dart';
import 'package:book_library/features/home/home_screen.dart';
import 'package:book_library/features/profile/profile_page.dart';
import 'package:flutter/material.dart';

class BNB extends StatefulWidget {
  const BNB({super.key});

  @override
  State<BNB> createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  int _selectedIndex = 0;

  final List _pages = [
    const HomeScreen(),
    const FavoriteBooks(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Opacity(
          opacity: 0.95,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              clipBehavior: Clip
                  .hardEdge, //or better look(and cost) using Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: BottomNavigationBar(
                elevation: 0,
                unselectedItemColor: Colors.white,
                backgroundColor: AppColors.bg2,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
