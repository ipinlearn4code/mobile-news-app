import 'package:flutter/material.dart';
import 'package:project_mob/core/utils/constant_color.dart';
import 'package:project_mob/presentation/pages/home_page.dart';
import 'package:project_mob/presentation/pages/profil_page.dart';
import 'package:project_mob/presentation/pages/search_page.dart';

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
  // Track the current index of the bottom navigation
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget
        .selectedIndex; // Initialize _currentIndex with the selected index passed from the parent widget
  }

  // Method to handle when a navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update _currentIndex to the tapped index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Conditional rendering of the pages based on _currentIndex
        Expanded(
          child: _currentIndex == 0
              ? const HomePage()
              : _currentIndex == 1
                  ? const SearchPage()
                  : ProfilePage(),
        ),

        // Bottom navigation bar
        BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
          ],
          currentIndex:
              _currentIndex, // Bind _currentIndex to track selected tab
          selectedItemColor:
              ConstantColor.primary, // Change the color of the selected item
          selectedFontSize: 14,
          onTap: _onItemTapped, // Trigger _onItemTapped when a tab is tapped
        ),
      ],
    );
  }
}
