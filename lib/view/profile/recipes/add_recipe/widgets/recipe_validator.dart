import 'package:flutter/material.dart';
import 'package:recipe_app/controllers/add_recipe.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/models/allrecipe_class.dart';
import 'package:recipe_app/view/profile/recipes/my_recipe_screen.dart';

class RecipeValidator {
  static void validateRecipe(
    BuildContext context,
    RecipeController rController,
    TextEditingController recipeNameController,
    TextEditingController recipeCategoryController,
    TextEditingController timeController,
    TextEditingController caloriesController,
    TextEditingController descriptionController,
    TextEditingController difficultyController,
    String userId,
    String imageUrl,
    List<String> ingredientsList,
    List<String> instructionsList,
  ) {
    // ignore: unnecessary_null_comparison
    if (userId == null) {
      showToast(message: 'User is not signed in');
      return;
    }

    String recipetime = timeController.text;
    String recipeCalories = caloriesController.text;
    String recipename = recipeNameController.text;
    String category = recipeCategoryController.text;
    String difficultylevel = difficultyController.text;
    String description = descriptionController.text;

    if (recipename.isEmpty ||
        description.isEmpty ||
        category.isEmpty ||
        recipetime.isEmpty ||
        recipeCalories.isEmpty ||
        difficultylevel.isEmpty ||
        imageUrl.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('All fields are required'),
            content: const Text('Please fill in all the required fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      return;
    }

    rController.addRecipes(
      Recipes(
        imageUrl: imageUrl,
        calories: caloriesController.text,
        category: recipeCategoryController.text,
        difficultyText: difficultyController.text,
        description: descriptionController.text,
        ingredients: ingredientsList,
        instructions: instructionsList,
        time: timeController.text,
        userId: userId,
        recipeName: recipeNameController.text,
      ),
      userId,
    );
    // Clear input fields
    recipeNameController.clear();
    recipeCategoryController.clear();
    timeController.clear();
    caloriesController.clear();
    descriptionController.clear();
    imageUrl = '';

    // Navigate back to MyRecipeScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyRecipeScreen(),
      ),
    );
  }
}
