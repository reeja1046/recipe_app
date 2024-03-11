import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/serivces/add_service.dart';
import 'package:recipe_app/screens/account/my_recipes/my_recipe_screen.dart';
import 'package:recipe_app/screens/account/my_recipes/widgets/add_ingredients.dart';
import 'package:recipe_app/screens/account/my_recipes/widgets/add_instructions.dart';
import 'package:recipe_app/screens/account/my_recipes/widgets/custom_appbar.dart';
import 'package:recipe_app/screens/account/my_recipes/widgets/photo_upload_section.dart';
import 'package:recipe_app/screens/account/my_recipes/widgets/radio_button.dart';
import 'package:recipe_app/screens/account/my_recipes/widgets/time_and_calories.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  TextEditingController recipeNameController = TextEditingController();
  TextEditingController recipeCategoryController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  String difficultyText = '';
  int selectedDifficulty = 0;
  String imageUrl = '';
  final RecipeService recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name of Your Recipe',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 42,
                      child: TextField(
                        controller: recipeNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the name',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BuildTimeAndCalories(
                      onTimeAndCaloriesChanged: updateTimeAndCalories,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Category',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 42,
                      child: TextField(
                        controller: recipeCategoryController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Biriyani/Friedrice/Noodles',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Difficulty',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    RadioButtonsRow(
                      onDifficultyChanged: updateDifficulty,
                      difficultyText: difficultyText,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ingredients',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      '(Enter each ingredient in each box) ',
                      style: TextStyle(fontSize: 12),
                    ),
                    const IngredientsForm(),
                    const Text(
                      'Instructions',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      '(Enter instructions step by step) ',
                      style: TextStyle(fontSize: 12),
                    ),
                    const AddInstructions(),
                    const SizedBox(height: 10),
                    PhotoUploadSection(
                      onImageSelected: (url) {
                        setState(() {
                          imageUrl = url;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.baseColor,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.baseColor,
                          ),
                          onPressed: () async {
                            Map<String, dynamic> recipeData = {
                              'Name': recipeNameController.text,
                              'Category': recipeCategoryController.text,
                              'est Time': timeController.text,
                              'Calories': caloriesController.text,
                              'Difficulty': selectedDifficulty,
                              'DifficultyText': difficultyText,
                              'Image': imageUrl,
                            };

                            addRecipe(recipeData);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>const MyRecipeScreen()));
                          },
                          child: const Text(
                            'Add Recipe',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateDifficulty(int difficulty, String difficultyText) {
    setState(() {
      selectedDifficulty = difficulty;
      this.difficultyText = difficultyText;
      print(this.difficultyText);
    });
  }

  void updateTimeAndCalories(String time, String calories) {
    setState(() {
      timeController.text = time;
      caloriesController.text = calories;
    });
  }

  void addRecipe(Map<String, dynamic> recipeData) {
    String recipetime = timeController.text;
    String recipeCalories = caloriesController.text;
    String recipename = recipeNameController.text;
    String category = recipeCategoryController.text;
    String difficultylevel = difficultyText.toString();
    int difficulty = selectedDifficulty;

    if (recipename.isEmpty ||
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

    print(difficulty);
    print(difficultylevel);
    print(recipename);
    print(recipeCalories);
    print(recipetime);
    print('888888888888888888888888888');
    print(category);
    recipeService.saveRecipeToFirebase(recipeData);
    recipeNameController.clear();
    recipeCategoryController.clear();
    timeController.clear();
    caloriesController.clear();
    imageUrl = '';
  }
}
