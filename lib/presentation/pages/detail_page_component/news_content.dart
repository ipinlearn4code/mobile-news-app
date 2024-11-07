import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/pages/full_news_page.dart';

class NewsContent extends StatelessWidget {
  final Article article;

  const NewsContent({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.content ??
                'Content is not available for this article.', // Fallback if content is null
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullNewsPage(
                      url: article.url,
                      title: article.title,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: Text('Read Full Article'),
            ),
          ),
        ],
      ),
    );
  }
}
