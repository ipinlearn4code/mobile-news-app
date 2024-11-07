import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/pages/home_page_component/news_list_card.dart';
import 'package:project_mob/presentation/pages/news_detail_page.dart';

class NewsList extends StatelessWidget {
  final List<Article> articles;

  const NewsList({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articles.length, // Number of news articles
      itemBuilder: (context, index) {
        final article = articles[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the NewsDetailPage
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                  article: article,
                  // title: article.title,
                  // img: Image.network(article.urlToImage ?? 'https://via.placeholder.com/400'),
                ),
              ),
            );
          },
          child: NewsListCard(article: article),
        );
      },
    );
  }
}
