// news_response.dart

import 'article.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  // Factory method to create a NewsResponse from JSON
  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var articlesList = json['articles'] as List;
    List<Article> articles = articlesList.map((articleJson) => Article.fromJson(articleJson)).toList();

    return NewsResponse(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: articles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}
