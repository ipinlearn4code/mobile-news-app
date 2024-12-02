import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_mob/core/utils/api_key.dart';
import 'package:project_mob/core/utils/news_api.dart';
import 'package:project_mob/presentation/data/models/news_response.dart';
import 'package:project_mob/presentation/data/services/cache_service.dart'; // Import CacheService

class NewsApiService {
  
  final CacheService cacheService = CacheService();  // Instantiate CacheService
  
  Future<Map<String, dynamic>> _getRequest(String endpoint, {Map<String, String>? parameters}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: {
      'apiKey': apiKey,
      ...?parameters,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from $endpoint');
    }
  }

  Future<NewsResponse> fetchTopHeadlines({String country = 'us'}) async {
    final cacheKey = '$cacheKeyPrefix$country-top-headlines';

    final cachedData = await cacheService.getCachedData(cacheKey);

    if (cachedData != null) {
      print('Using cached data for Top Headlines');
      return NewsResponse.fromJson(cachedData);
    }

    final data = await _getRequest('/top-headlines', parameters: {'country': country, 'pageSize': '5'});

    await cacheService.cacheDataWithExpiration(cacheKey, data);

    return NewsResponse.fromJson(data);
  }

  Future<NewsResponse> fetchByCategory(String category, {String country = 'us'}) async {
    final cacheKey = '$cacheKeyPrefix$category-$country-top-headlines';

    final cachedData = await cacheService.getCachedData(cacheKey);

    if (cachedData != null) {
      print('Using cached data for Category: $category');
      return NewsResponse.fromJson(cachedData);
    }

    final data = await _getRequest('/top-headlines', parameters: {
      'country': country,
      'category': category,
      'pageSize': '5'
    });

    await cacheService.cacheDataWithExpiration(cacheKey, data);

    return NewsResponse.fromJson(data);
  }

  Future<NewsResponse> searchArticles(String query, {String language = 'en', int page = 1}) async {
    final cacheKey = '$cacheKeyPrefix$query-$language-search';

    final cachedData = await cacheService.getCachedData(cacheKey);

    if (cachedData != null) {
      print('Using cached data for Search Query: $query');
      return NewsResponse.fromJson(cachedData);
    }

    final data = await _getRequest('/everything', parameters: {
      'q': query,
      'language': language,
      'pageSize': '5',
      'page': '$page'
    });

    await cacheService.cacheDataWithExpiration(cacheKey, data);

    return NewsResponse.fromJson(data);
  }
}
