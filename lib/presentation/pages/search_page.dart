import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/api_response.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/data/services/news_api_services.dart';
import 'package:project_mob/presentation/pages/home_page_component/news_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final NewsApiService _newsApiService = NewsApiService(); // Instantiate the service
  List<Article> _articles = [];
  bool _isLoading = false;
  String _query = ''; // The search query
  bool _isFocused = false; // Track focus state of the text field

  // Method to perform search
  void _searchArticles() async {
    if (_query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      ApiResponse response = await _newsApiService.searchArticles(_query);
      setState(() {
        _articles = response.articles;
      });
    } catch (e) {
      // Handle error here (you could show an error message to the user)
      print('Error fetching articles: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Handle focus change to animate the search field
  void _onFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
    });
  }

  // Build the search input and list of articles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(  // Make the entire body scrollable
        padding: EdgeInsets.only(top: 60, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animated Search Field
            AnimatedContainer(
              duration: const Duration(milliseconds: 300), // Set duration of the animation
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: _isFocused ? 50 : 80,  // Adjust height based on focus
              alignment: _isFocused ? Alignment.centerLeft : Alignment.center, // Adjust position based on focus
              curve: Curves.easeInOut,
              child: TextField(
                focusNode: FocusNode()..addListener(() {
                  _onFocusChange(true);
                }), // When text field is focused, set _isFocused to true
                decoration: InputDecoration(
                  hintText: 'Search...', // Placeholder text
                  border: _isFocused ? OutlineInputBorder() : InputBorder.none , // No border on TextField itself
                  contentPadding: EdgeInsets.symmetric(horizontal: 16), // Padding inside the TextField
                  suffixIcon: !_isFocused ? Icon(
                    Icons.search,
                    color: Colors.grey, // Color of the search icon
                  ) : null,  // Hide icon when focused
                ),
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                  _searchArticles();  // Trigger search as the user types
                },
              ),
            ),

            const SizedBox(height: 10),

            // Loading Indicator
            if (_isLoading) const CircularProgressIndicator(),

            // No results found message
            if (!_isLoading && _articles.isEmpty && _query.isNotEmpty)
              const Text('No results found'),

            // Display search results using NewsList
            if (!_isLoading && _articles.isNotEmpty)
              NewsList(articles: _articles), // Removed Expanded to allow scrolling
          ],
        ),
      ),
    );
  }
}
