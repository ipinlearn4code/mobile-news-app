import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsImage extends StatelessWidget {
  final String imageUrl;

  const NewsImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  // PrintHandler
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Image.network(
        'https://via.placeholder.com/400',
        fit: BoxFit.cover,
      ),
      
    );
  }
}
