import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/widgets/circle_back_button.dart';
import 'package:project_mob/presentation/pages/detail_page_component/container_news_image.dart';
import 'package:project_mob/presentation/pages/detail_page_component/like_button.dart';
import 'package:project_mob/presentation/pages/detail_page_component/news_content.dart';

// ignore: must_be_immutable
class NewsDetailPage extends StatelessWidget {
  NewsDetailPage({Key? key, required this.article}) : super(key: key);
  // String title;
  // Image? img;
  Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // News disini
                ContainerNewsImage(
                  img: Image.network(article.urlToImage ?? 'https://via.placeholder.com/400'),
                ),
                SizedBox(height: 50),
                
                NewsContent(article: article),
              ],
            ),
            // Overlay Back Button
            Positioned(
              top: 32,
              left: 16,
              child: CircleBackButton(),
            ),
            // Overlay News Title
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black54, // semi-transparent background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sunday, 9 May 2021',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        article.title.isEmpty ? 'Judul Beritanya kosong' : article.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Published by Lorem Ipsum',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: LikeButton(),
    );
  }
}
