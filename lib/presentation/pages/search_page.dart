import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/news_response.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/data/services/news_api_services.dart';
import 'package:project_mob/presentation/pages/home_page_component/news_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> _recentSearches = [];
  late FocusNode _focusNode;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Load recent searches from shared_preferences
  void _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  // Save recent search to shared_preferences
  void _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recent_searches', _recentSearches);
  }

  // Method to perform search
  void _searchArticles() async {
    if (_query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      NewsResponse response = await _newsApiService.searchArticles(_query);
      setState(() {
        _articles = response.articles;
      });
      if (!_recentSearches.contains(_query)) {
        setState(() {
          _recentSearches.add(_query);
        });
        _saveRecentSearches();
      }
    } catch (e) {
      print('Error fetching articles: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Handle focus change to animate the search field
  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  // Clear the current search query
  void _clearSearch() {
    setState(() {
      _query = '';
      _controller.clear();
      _articles = [];
    });
  }

  // Handle back button action (unfocus the search field)
  void _onBackButtonPressed() {
    if (_isFocused) {
      // Unfocus the search field (close keyboard and hide recent searches)
      _focusNode.unfocus();
      setState(() {
        _isFocused = false;
      });
    } else {
      // If already unfocused, allow normal back navigation
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: _isFocused
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: _onBackButtonPressed,
              )
            : null, // Hide the back button when search field is not focused
        title: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isFocused ? 40 : 50,
          curve: Curves.easeInOut,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.black),
                      onPressed: _clearSearch,
                    )
                  : IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: _searchArticles,
                    ),
            ),
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            onSubmitted: (value) {
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
              // Show recent searches only when the search field is focused
              if (_isFocused && _recentSearches.isNotEmpty) ...[
                Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                SingleChildScrollView(
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
                            _controller.text = recentSearch; // Update text field
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
              if (_articles.isEmpty && !_isLoading && _query.isNotEmpty) const Text('No results found.'),
              if (!_isLoading && _articles.isNotEmpty)
                NewsList(articles: _articles),
            ],
          ),
        ),
      ),
    );
  }
}
