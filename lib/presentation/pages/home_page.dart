import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/data/services/news_api_services.dart';
import 'package:project_mob/presentation/pages/home_page_component/carousel.dart';
import 'package:project_mob/presentation/pages/home_page_component/news_list.dart';
import 'package:project_mob/presentation/widgets/tab_nav_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabNavIndex = 0;
  List<Article> articles = [];
  List<Article> articlesByCategory = [];
  bool isLoadingHeadlines = true;
  bool isLoadingByCategory = true;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
    _fetchArticlesByCategory('general');
  }

  Future<void> _fetchArticles() async {
    try {
      log("Fetching All Articles");
      final apiService = NewsApiService();
      final response = await apiService.fetchTopHeadlines();
      setState(() {
        articles = response.articles;
        isLoadingHeadlines = false;
      });
    } catch (error) {
      print("Error fetching articles: $error");
      setState(() {
        isLoadingHeadlines = false;
      });
    }
  }

  Future<void> _fetchArticlesByCategory(String category) async {
    try {
      final apiService = NewsApiService();
      final response = await apiService.fetchByCategory(category);
      setState(() {
        articlesByCategory = response.articles;
        isLoadingByCategory = false;
      });
    } catch (error) {
      print("Error fetching articles: $error");
      setState(() {
        isLoadingByCategory = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Berita Terkini',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            isLoadingHeadlines
                ? Center(child: CircularProgressIndicator())
                : Carousel(articles: articles),
            TabNavCategory(
              onTabSelected: _fetchArticlesByCategory, // Pass new method
            ),
            isLoadingByCategory
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : NewsList(articles: articlesByCategory),
            SizedBox(height: 90),
          ],
        ),
        // ),
        // // bottomNavigationBar: BottomNavBar(
        // //   selectedIndex: 0,
      ),
    );
  }
}
