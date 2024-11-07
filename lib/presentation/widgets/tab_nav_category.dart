
import 'package:flutter/material.dart';

class TabNavCategory extends StatefulWidget {
  final Function(String) onTabSelected; // Change callback to accept category string

  const TabNavCategory({
    super.key,
    required this.onTabSelected,
  });

  @override
  _TabNavCategoryState createState() => _TabNavCategoryState();
}

class _TabNavCategoryState extends State<TabNavCategory> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabButton('General', 0, 'general'),
            _buildTabButton('Business', 1, 'business'),
            _buildTabButton('Entertainment', 2, 'entertainment'),
            _buildTabButton('Health', 3, 'health'),
            _buildTabButton('Science', 4, 'science'),
            _buildTabButton('Sports', 5, 'sports'),
            _buildTabButton('Technology', 6, 'technology'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index, String category) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onTabSelected(category); // Pass category to callback
      },
      child: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}
