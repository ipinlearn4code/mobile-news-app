import 'package:project_mob/presentation/data/models/article.dart';

class ApiResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  ApiResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  // Factory method to create a NewsResponse from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var articlesList = json['articles'] as List;
    List<Article> articles =
        articlesList.map((article) => Article.fromJson(article)).toList();

    return ApiResponse(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: articles,
    );
  }
}