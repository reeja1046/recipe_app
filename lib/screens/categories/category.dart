import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/recipe_card.dart';
import 'package:recipe_app/screens/categories/category_button.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: CategoryButtons()),
            const SizedBox(height: 16.0),
            const Expanded(
              child: RecipeGridView(),
            ),
          ],
        )),
      ),
    );
  }
}
