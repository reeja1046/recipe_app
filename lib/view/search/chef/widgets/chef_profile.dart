import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_search.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/models/myrecipe_class.dart';
import 'package:recipe_app/models/user_class.dart';
import 'package:recipe_app/view/search/chef/widgets/chef_header_part.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class ChefProfile extends StatelessWidget {
  final MyUsers user;

  const ChefProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRecipeController controller = Get.put(UserRecipeController(
        userId: user.userId!)); // Pass userId to UserRecipeController

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChefHeaderPart(user: user), // Pass the user object to ChefHeaderPart
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'My Recipes',
              style: TextSize.titletextsize,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: controller.recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final MyRecipes recipe = controller.recipes[index];
                print(recipe);

                return GestureDetector(
                  onTap: () {
                    print(recipe.recipeId);
                    print("________________");
                    print('Tapped on ${recipe.recipeName}');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailedRecipeScreen(
                          recipeId: recipe.recipeId.toString(),
                          userId: user.userId!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          recipe.imageUrl!,
                          height: 120.0,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Image.asset(
                                'assets/placeholder.jpg',
                                height: 120.0,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipe.recipeName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.baseColor),
          onPressed: () {},
          child: const Text(
            'Follow',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
