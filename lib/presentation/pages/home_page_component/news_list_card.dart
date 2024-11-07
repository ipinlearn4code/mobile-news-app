import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/widgets/news_image.dart';

class NewsListCard extends StatelessWidget {
  final Article article;

  const NewsListCard({
    required this.article,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Background Image
          Container(
            height: 150,
            width: double.infinity,
            child: NewsImage(
              imageUrl: article.urlToImage ?? 'https://via.placeholder.com/400',
            ),
            
            // clipBehavior: Clip.hardEdge,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   image: DecorationImage(
            //     image: article.urlToImage != null
            //         ? NetworkImage(article.urlToImage!)
            //         : NetworkImage('https://via.placeholder.com/400'),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // width: double.infinity,
            // height: double.infinity,
          ),
          // Title and description on top of the image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    article.description ?? 'No description available',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
