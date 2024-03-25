import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/view/wishlist/favrecipegridview.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: const Padding(
          padding: EdgeInsets.all(10.0), child: FavRecipeGridView()),
    );
  }
}
