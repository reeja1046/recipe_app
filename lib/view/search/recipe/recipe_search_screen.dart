import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class RecipeSearchScreen extends StatelessWidget {
  const RecipeSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        Text(
                          '    Search',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 40,
                width: 40,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {}, // Navigate to filter screen
                    child: Image.asset(
                      'assets/filter.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'All Recipes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<MyAllRecipes>>(
            future: RecipeService().getAllRecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<MyAllRecipes> recipes = snapshot.data!;
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
                    MyAllRecipes recipe = recipes[index];
                    print(recipe.recipeName);
                    print(recipe.userId);
                    print('*******--------/////--------***********');
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailedRecipeScreen(
                                recipeId: recipe.recipeId!,
                                userId: recipe.userId!)));
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
          ),
        ],
      ),
    );
  }
}
