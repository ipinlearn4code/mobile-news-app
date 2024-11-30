import 'package:flutter/material.dart';
import 'package:project_mob/presentation/data/models/article.dart';
import 'package:project_mob/presentation/widgets/news_image.dart';

class CarouselCard extends StatelessWidget {
  final Article article;

  const CarouselCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: 300,
          height: 400,
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 400,
                child: NewsImage(imageUrl: article.urlToImage.toString()),
                // child: Image.network(
                //   article.urlToImage ?? 'https://via.placeholder.com/400',
                //   fit: BoxFit.cover,
                // ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          article.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          truncateDescription(
                            article.description ?? 'No description available',
                            15,
                          ),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String truncateDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length > wordLimit) {
      return words.sublist(0, wordLimit).join(' ') + '...';
    }
    return description;
  }
}
