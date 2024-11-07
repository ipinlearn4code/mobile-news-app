import 'package:flutter/material.dart';

class ContainerNewsImage extends StatelessWidget {
  const ContainerNewsImage({
    super.key,
    this.img,
  });

  final Image? img;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Image(
          image: img != null
              ? img!.image
              : NetworkImage('https://via.placeholder.com/400'),
          fit: BoxFit.fill),
    );
  }
}
