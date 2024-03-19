import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/view/wishlist/favrecipegridview.dart';
import 'package:recipe_app/widgets/bottomnavbar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => BottomNavBar())));
          },
        ),
        backgroundColor: AppColor.baseColor,
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
