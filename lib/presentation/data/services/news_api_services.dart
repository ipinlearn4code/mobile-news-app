import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_mob/presentation/data/services/api_key.dart';
import '../models/article.dart';
import '../models/api_response.dart';

class NewsApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = apiKey;

  Future<ApiResponse> fetchTopHeadlines({String country = 'us'}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return ApiResponse(
          status: data['status'],
          articles: articles,
          totalResults: data['totalResults']);
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<ApiResponse> fetchByCategory(String category,
      {String country = 'us'}) async {
    final uri = Uri.parse(
      '$_baseUrl/top-headlines?country=$country&category=$category&apiKey=$_apiKey',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return ApiResponse(
          status: data['status'],
          articles: articles,
          totalResults: data['totalResults']);
    } else {
      throw Exception('Failed to load articles by category');
    }
  }

  Future<ApiResponse> searchArticles(String query,
      {String language = 'en', int pageSize = 7, int page = 1}) async {
    final uri = Uri.parse(
      '$_baseUrl/everything?q=$query&language=$language&pageSize=$pageSize&page=$page&apiKey=$_apiKey',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return ApiResponse(
          status: data['status'],
          articles: articles,
          totalResults: data['totalResults']);
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
