import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40, // Adjusted height for better appearance
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(color: Colors.grey.withOpacity(0.5)), // Grey border
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...', // Placeholder text
          border: InputBorder.none, // No border on TextField itself
          contentPadding: EdgeInsets.symmetric(horizontal: 16), // Padding inside the TextField
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey, // Color of the search icon
          ),
        ),
      ),
    );
  }
}
