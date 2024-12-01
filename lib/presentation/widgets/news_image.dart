import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final String? errorImageUrl;
  final Widget? placeholder;
  final BoxFit fit;

  const NewsImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.errorImageUrl = 'https://via.placeholder.com/400', // Default error image
    this.placeholder,
    this.fit = BoxFit.cover, // Default fit is cover
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ?? 
        Center(child: CircularProgressIndicator()), // Customizable placeholder
      errorWidget: (context, url, error) => Image.network(
        errorImageUrl!,
        fit: fit,
      ),
      fadeInDuration: Duration(milliseconds: 500), // Optional: smooth fade-in
      fadeOutDuration: Duration(milliseconds: 300),
    );
  }
}
