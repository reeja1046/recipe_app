import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/my_recipes.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        centerTitle: true,
        title: const Text(
          'My Recipes',
          style: TextStyle(fontSize: 26),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "edit",
                child: Text("Edit"),
              ),
              const PopupMenuItem(
                value: "delete",
                child: Text("Delete"),
              ),
            ],
            onSelected: (value) {
              if (value == "edit") {
                showEditOptions(context);
              } else if (value == "delete") {
                showDeleteOptions(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Obx(() {
            if (controller.recipes.isEmpty) {
              return const Center(
                child: Text(
                  'No Recipes Found',
                  style: TextSize.subtitletextsize,
                ),
              );
            } else {
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
                Get.to(() => const AddRecipe(
                      recipeDetail: null,
                    ));
              },
              child: const Text(
                'Add Recipe',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            // ElevatedButton(
            //   style:
            //       ElevatedButton.styleFrom(backgroundColor: AppColor.baseColor),
            //   onPressed: () {},
            //   child: const Text(
            //     'Create Cookbook',
            //     style: TextStyle(color: Colors.white, fontSize: 16),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void showDeleteOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select recipe to delete"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (MyRecipes recipe in controller.recipes)
                ListTile(
                  title: Text(recipe.recipeName!),
                  onTap: () {
                    _deleteRecipe(context, recipe);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // Function to delete the selected recipe
  void _deleteRecipe(BuildContext context, MyRecipes recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content:
              Text("Are you sure you want to delete ${recipe.recipeName}?"),
          actions: [
            TextButton(
              onPressed: () {
                controller.deleteRecipe(recipe);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void showEditOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose one to edit"),
          content: SizedBox(
            height: 200,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (MyRecipes recipe in controller.recipes)
                      ListTile(
                        title: Text(recipe.recipeName!),
                        onTap: () {
                          fetchRecipeDetails(recipe.recipeId);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  fetchRecipeDetails(recipeId) async {
    print('^^^^^^^^^&&&&&&&&&&^^^^^^');
    print(recipeId);
    var recipeDetail = await FirebaseFirestore.instance
        .collection('add recipes')
        .doc(userId)
        .collection('recipes')
        .doc(recipeId)
        .get();
    print(recipeDetail.data());
    var instruction = recipeDetail.data()!['instructions'];
    print(instruction);
    if (recipeDetail.data() != null) {
      Get.to(() => AddRecipe(recipeDetail: recipeDetail));
    }
  }
}
