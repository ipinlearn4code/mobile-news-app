import 'package:flutter/material.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor:
          Colors.black54,
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
