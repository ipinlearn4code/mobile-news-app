import 'package:flutter/material.dart';
import 'package:project_mob/presentation/widgets/bottom_nav_bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Favorite Page'),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1,),
    );
  }
}
