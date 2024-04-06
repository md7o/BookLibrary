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
        child: BottomNavigationBar(
          elevation: 0,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xEC131313),
          iconSize: 30,
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
          selectedItemColor: AppColors.primary,
          unselectedIconTheme: IconThemeData(color: Colors.white54, size: 25),
          unselectedLabelStyle: TextStyle(color: Colors.white54, fontSize: 10),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
