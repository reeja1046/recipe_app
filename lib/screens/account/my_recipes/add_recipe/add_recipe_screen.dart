import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/sizedbox.dart';
import 'package:recipe_app/app/constants/text_strings.dart';
import 'package:recipe_app/app/serivces/add_service.dart';
import 'package:recipe_app/screens/account/my_recipes/my_recipe_screen.dart';
import 'package:recipe_app/screens/account/my_recipes/add_recipe/widgets/add_ingredients.dart';
import 'package:recipe_app/screens/account/my_recipes/add_recipe/widgets/add_instructions.dart';
import 'package:recipe_app/screens/account/my_recipes/add_recipe/widgets/custom_appbar.dart';
import 'package:recipe_app/screens/account/my_recipes/add_recipe/widgets/photo_upload_section.dart';
import 'package:recipe_app/screens/account/my_recipes/add_recipe/widgets/radio_button.dart';
import 'package:recipe_app/screens/account/my_recipes/add_recipe/widgets/time_and_calories.dart';

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
  TextEditingController descriptionController = TextEditingController();
  String difficultyText = '';
  int selectedDifficulty = 0;
  String imageUrl = '';
  List<String> ingredientsList = [];
  final RecipeService recipeService = RecipeService();

  SizedBoxHeightWidth sizedboxhelper = SizedBoxHeightWidth();

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
                    subtitletext('Name of Your Recipe'),
                    sizedboxhelper.kheight10,
                    nameAndCategoryField(
                        'Enter your name', recipeNameController),
                    sizedboxhelper.kheight10,
                    BuildTimeAndCalories(
                      onTimeAndCaloriesChanged: updateTimeAndCalories,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Category'),
                    sizedboxhelper.kheight10,
                    nameAndCategoryField(
                        'Biriyani/Friedrice/Noodles', recipeCategoryController),
                    sizedboxhelper.kheight10,
                    subtitletext('Difficulty'),
                    RadioButtonsRow(
                      onDifficultyChanged: updateDifficulty,
                      difficultyText: difficultyText,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Description'),
                    sizedboxhelper.kheight10,
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter a description about your recipe',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(color: AppColor.baseColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(color: AppColor.baseColor),
                        ),
                      ),
                      maxLines:
                          5, // Allow multiple lines for longer descriptions
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Ingredients'),
                    sizedboxhelper.kheight10,
                    IngredientsForm(
                      onIngredientsChanged: handleIngredientsChanged,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Instructions'),
                    sizedboxhelper.kheight10,
                    const AddInstructions(),
                    sizedboxhelper.kheight10,
                    subtitletext('Upload Photos'),
                    sizedboxhelper.kheight10,
                    PhotoUploadSection(
                      onImagesSelected: (urls) {
                        setState(() {
                          imageUrl = urls.isNotEmpty ? urls.first : '';
                        });
                      },
                    ),
                    sizedboxhelper.kheight10,
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
                              'Description': descriptionController.text,
                            };

                            addRecipe(recipeData, ingredientsList);
                          },
                          child: const Text(
                            'Save',
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

  void handleIngredientsChanged(List<String> ingredients) {
    setState(() {
      ingredientsList = ingredients;
      print('Ingredients:');
      for (var ingredient in ingredientsList) {
        print(ingredient);
      }
    });
  }

  void addRecipe(
      Map<String, dynamic> recipeData, List<String> ingredientsList) {
    String recipetime = timeController.text;
    String recipeCalories = caloriesController.text;
    String recipename = recipeNameController.text;
    String category = recipeCategoryController.text;
    String difficultylevel = difficultyText.toString();
    String description = descriptionController.text;
    // int difficulty = selectedDifficulty;
    print('Ingredients:');
    for (var ingredient in ingredientsList) {
      print('7777788888888886666666666666655555555');
      print(ingredient);
    }
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

    recipeService.saveRecipeToFirebase(recipeData);
    recipeNameController.clear();
    recipeCategoryController.clear();
    timeController.clear();
    caloriesController.clear();
    descriptionController.clear();
    imageUrl = '';
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MyRecipeScreen(),
      ),
    );
  }

  Widget nameAndCategoryField(hintText, controller) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColor.baseColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColor.baseColor),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.only(left: 15),
        ),
      ),
    );
  }

  Widget subtitletext(text) {
    return Text(
      text,
      style: TextSize.subtitletextsize,
    );
  }
}
