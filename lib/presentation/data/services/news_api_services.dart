import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_mob/presentation/data/models/news_response.dart';
import 'package:project_mob/presentation/data/services/api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = apiKey;
  static const String _cacheKeyPrefix = 'newsCache_';  // Key prefix for caching

  // Private method to handle HTTP requests
  Future<Map<String, dynamic>> _getRequest(String endpoint, {Map<String, String>? parameters}) async {
    final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: {
      'apiKey': _apiKey,
      ...?parameters,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from $endpoint');
    }
  }

  // Private method to cache data in shared_preferences
  Future<void> _cacheData(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(data)); // Save data as JSON string
  }

  // Private method to get cached data
  Future<Map<String, dynamic>?> _getCachedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      return json.decode(cachedData);  // Return the decoded JSON
    }

    return null;
  }

  // Fetch Top Headlines with 5 articles limit (using cache)
  Future<NewsResponse> fetchTopHeadlines({String country = 'us'}) async {
    final cacheKey = '$_cacheKeyPrefix$country-top-headlines';

    // Check for cached data first
    final cachedData = await _getCachedData(cacheKey);

    if (cachedData != null) {
      print('Using cached data for Top Headlines');
      return NewsResponse.fromJson(cachedData);
    }

    // No cached data, fetch from API
    final data = await _getRequest('/top-headlines', parameters: {'country': country, 'pageSize': '5'});

    // Cache the fetched data
    await _cacheData(cacheKey, data);

    return NewsResponse.fromJson(data);
  }

  // Fetch Articles by Category with 5 articles limit (using cache)
  Future<NewsResponse> fetchByCategory(String category, {String country = 'us'}) async {
    final cacheKey = '$_cacheKeyPrefix$category-$country-top-headlines';

    // Check for cached data first
    final cachedData = await _getCachedData(cacheKey);

    if (cachedData != null) {
      print('Using cached data for Category: $category');
      return NewsResponse.fromJson(cachedData);
    }

    // No cached data, fetch from API
    final data = await _getRequest('/top-headlines', parameters: {
      'country': country,
      'category': category,
      'pageSize': '5'
    });

    // Cache the fetched data
    await _cacheData(cacheKey, data);

    return NewsResponse.fromJson(data);
  }

  // Fetch Articles by Search Query with 5 articles limit (using cache)
  Future<NewsResponse> searchArticles(String query, {String language = 'en', int page = 1}) async {
    final cacheKey = '$_cacheKeyPrefix$query-$language-search';

    // Check for cached data first
    final cachedData = await _getCachedData(cacheKey);

    if (cachedData != null) {
      print('Using cached data for Search Query: $query');
      return NewsResponse.fromJson(cachedData);
    }

    // No cached data, fetch from API
    final data = await _getRequest('/everything', parameters: {
      'q': query,
      'language': language,
      'pageSize': '5',
      'page': '$page'
    });

    // Cache the fetched data
    await _cacheData(cacheKey, data);

    return NewsResponse.fromJson(data);
  }
}
