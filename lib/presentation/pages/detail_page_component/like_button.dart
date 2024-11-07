import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Add to favorites or any other action
      },
      child: Icon(Icons.favorite),
      backgroundColor: Colors.redAccent,
    );
  }
}
