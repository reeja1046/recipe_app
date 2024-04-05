import 'package:flutter/material.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class QuickAndEasyCard extends StatefulWidget {
  const QuickAndEasyCard({super.key});

  @override
  State<QuickAndEasyCard> createState() => _QuickAndEasyCardState();
}

class _QuickAndEasyCardState extends State<QuickAndEasyCard> {
  List recipes = [];
  @override
  void initState() {
    fetchRecipes();
    super.initState();
  }

  Future<void> fetchRecipes() async {
    final List<AllRecipesList> fetchedRecipes =
        await RecipeService().getAllRecipes();

    List<AllRecipesList> filteredRecipes = [];

    for (var recipe in fetchedRecipes) {
      int? estTimeInt = int.tryParse(recipe.time ?? '');
      if (estTimeInt != null && estTimeInt < 30) {
        filteredRecipes.add(recipe);
      }
      print(estTimeInt);

      print('#######@@@@@@@@@###########');
    }
    print('&&&&&&******&&&&&*****&&&&*****&&&&&&&&&&*******');

    setState(() {
      recipes = filteredRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    recipe.imageUrl ?? '',
                    fit: BoxFit.cover,
                    height: 130,
                  ),
                ),
                Text(
                  recipe.recipeName ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
