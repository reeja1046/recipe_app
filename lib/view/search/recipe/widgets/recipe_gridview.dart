import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class RecipeSearchGridView extends StatelessWidget {
  const RecipeSearchGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AllRecipesList>>(
      future: RecipeService().getAllRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<AllRecipesList> recipes = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              AllRecipesList recipe = recipes[index];
              print(recipe.recipeName);
              print(recipe.userId);
              print('*******--------/////--------***********');
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailedRecipeScreen(
                          recipeId: recipe.recipeId!, userId: recipe.userId!)));
                },
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black45,
                    title: Text(
                      recipe.recipeName ?? '',
                      textAlign: TextAlign.center,
                      style: TextSize.subtitletextsize,
                    ),
                  ),
                  child: Image.network(
                    recipe.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        } else {
          return const Text('No recipes found');
        }
      },
    );
  }
}
