class ArticleSource {
  final String? id;
  final String name;

  ArticleSource({this.id, required this.name});

  factory ArticleSource.fromJson(Map<String, dynamic> json) {
    return ArticleSource(
      id: json['id'] as String?,
      name: json['name'] as String,
    );
  }
}

// Model for the article
class Article {
  final ArticleSource source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  // Factory method to create an Article from JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: ArticleSource.fromJson(json['source']),
      author: json['author'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] as String?,
    );
  }
}