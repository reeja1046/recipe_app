import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class CategoryCard extends StatelessWidget {
  final List<AllRecipesList> filteredRecipes;

  const CategoryCard({Key? key, required this.filteredRecipes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          AllRecipesList recipe = filteredRecipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailedRecipeScreen(
                    recipeId: recipe.recipeId!,
                    userId: recipe.userId!,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      recipe.imageUrl ?? '',
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.recipeName ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/colorie.png',
                                  color: AppColor.baseColor,
                                  height: 20,
                                  width: 20,
                                ),
                                Text(recipe.calories!),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  size: 18,
                                ),
                                Text(recipe.time!),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
