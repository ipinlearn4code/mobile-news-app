import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/pages/home_page_component/carousel_card.dart';

class Carousel extends StatelessWidget {
  final List<Article> articles;

  const Carousel({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 250,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: articles.map((article) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CarouselCard(article: article),
            );
          }).toList(),
        ),
      ),
    );
  }
}
