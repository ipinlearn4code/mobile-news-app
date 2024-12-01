import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/widgets/circle_back_button.dart';
import 'package:project_mob/presentation/pages/detail_page_component/container_news_image.dart';
import 'package:project_mob/presentation/pages/detail_page_component/like_button.dart';
import 'package:project_mob/presentation/pages/detail_page_component/news_content.dart';
import 'package:intl/intl.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({Key? key, required this.article}) : super(key: key);

  String formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';
    return DateFormat('EEEE, d MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // News Image
                ContainerNewsImage(
                  img: Image.network(article.urlToImage ?? 'https://via.placeholder.com/400'),
                ),
                SizedBox(height: 50),

                // News Content
                NewsContent(article: article),
              ],
            ),

            // Overlay Back Button
            Positioned(
              top: 32,
              left: 16,
              child: const CircleBackButton(),
            ),

            // Overlay News Title
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: NewsTitleOverlay(article: article),
            ),
          ],
        ),
      ),
      floatingActionButton: const LikeButton(),
    );
  }
}

class NewsTitleOverlay extends StatelessWidget {
  final Article article;

  const NewsTitleOverlay({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    final String formattedDate = article.publishedAt != null 
        ? DateFormat('EEEE, d MMM yyyy').format(article.publishedAt)
        : 'Unknown Date';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black54, // semi-transparent background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            article.title.isEmpty ? 'Judul Beritanya kosong' : article.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Published by : ${article.author}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
