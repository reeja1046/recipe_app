import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/recipe_card.dart';
import 'package:recipe_app/view/categories/category_button.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: CategoryButtons()),
            SizedBox(height: 16.0),
            Expanded(
              child: RecipeGridView(),
            ),
          ],
        )),
      ),
    );
  }
}
