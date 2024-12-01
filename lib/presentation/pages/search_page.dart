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
  final NewsApiService _newsApiService = NewsApiService(); 
  List<Article> _articles = [];
  bool _isLoading = false;
  String _query = ''; 
  bool _isFocused = false; 
  List<String> _recentSearches = []; // To keep track of recent searches

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

  // Add recent search to the list
  void _addRecentSearch(String query) {
    if (!_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.add(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isFocused ? 40 : 50,
          curve: Curves.easeInOut,
          child: TextField(
            autofocus: false,
            focusNode: FocusNode()..addListener(() {
              _onFocusChange(true);
            }),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: _searchArticles,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _query = value;
              });
              _searchArticles();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent searches and suggestions
              if (!_isFocused && _recentSearches.isNotEmpty) ...[
                Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _recentSearches.length,
                    itemBuilder: (context, index) {
                      String recentSearch = _recentSearches[index];
                      return ListTile(
                        title: Text(recentSearch),
                        onTap: () {
                          setState(() {
                            _query = recentSearch;
                          });
                          _searchArticles();
                        },
                      );
                    },
                  ),
                ),
              ],
          
              // Loading indicator
              if (_isLoading) const Center(child: CircularProgressIndicator()),
          
              // No results found message
              if (!_isLoading && _articles.isEmpty && _query.isNotEmpty)
                const Text('No results found'),
          
              // Display search results
              if (!_isLoading && _articles.isNotEmpty)
                NewsList(articles: _articles),
            ],
          ),
        ),
      ),
    );
  }
}
