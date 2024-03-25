import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/myrecipes_controller.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/models/myrecipe_class.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/add_recipe_screen.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

// ignore: must_be_immutable
class MyRecipeScreen extends StatelessWidget {
  MyRecipeScreen({Key? key}) : super(key: key);

  final MyRecipeController controller = Get.put(MyRecipeController());
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    print(controller.toString());
    print('################5555555555555###################');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Obx(() {
            print('%%%%%%%55555555555%%%%%%%%');
            if (controller.recipes.isEmpty) {
              return const Center(
                child: Text(
                  'No Recipes Found',
                  style: TextSize.subtitletextsize,
                ),
              );
            } else {
              print('********555555555**********');
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: controller.recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  final MyRecipes recipe = controller.recipes[index];

                  return GestureDetector(
                    onTap: () {
                      print(recipe.recipeId);
                      print("________________");
                      print('Tapped on ${recipe.recipeName}');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailedRecipeScreen(
                            recipeId: recipe.recipeId.toString(),
                            userId: userId,
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
              );
            }
          }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColor.baseColor),
              onPressed: () {
                Get.to(() => const AddRecipe());
              },
              child: const Text(
                'Add Recipe',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColor.baseColor),
              onPressed: () {},
              child: const Text(
                'Create Cookbook',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
