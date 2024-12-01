// article_source.dart

class ArticleSource {
  final String? id;
  final String name;

  ArticleSource({this.id, required this.name});

  // Factory method to create an ArticleSource from JSON
  factory ArticleSource.fromJson(Map<String, dynamic> json) {
    return ArticleSource(
      id: json['id'] as String?,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
