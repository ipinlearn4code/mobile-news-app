import 'package:flutter/material.dart';
import 'package:project_mob/core/utils/constant_color.dart';
import 'package:project_mob/presentation/pages/favorite_page.dart';
import 'package:project_mob/presentation/pages/home_page.dart';
import 'package:project_mob/presentation/pages/profil_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    //Verif apakah di halaman yang sama
    if (index == widget.selectedIndex) {
      return;
    }
    setState(() {
      int _currentIndex = index; // Update the current index
    });

    // Handle navigasi
    switch (index) {
      case 0: // Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        break;
      case 1: // Favorite
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FavoritePage()),
            ); // Update with your favorite route
        break;
      case 2: // Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage()), // Navigate to ProfilePage
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: widget.selectedIndex, // Use the state variable for currentIndex
      selectedItemColor: ConstantColor.primary,
      selectedFontSize: 14,
      onTap: _onItemTapped, // Use the custom tap handler
    );
  }
}
