import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/appBar.dart';
import 'package:recipe_app/view/wishlist/favrecipegridview.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        text: 'Favorites',
      ),
      body: Padding(padding: EdgeInsets.all(10.0), child: FavRecipeGridView()),
    );
  }
}
