import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/controllers/addrecipe_controller.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/add_ingredients.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/add_instructions.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/category_dropdown.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/custom_appbar.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/description_section.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/name_section.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/photo_upload_section.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/radio_button.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/recipe_validator.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/time_and_calories.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final RecipeController rController = Get.put(RecipeController());

  TextEditingController recipeNameController = TextEditingController();
  TextEditingController recipeCategoryController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String difficultyText = '';
  int selectedDifficulty = 0;
  String imageUrl = '';
  List<String> ingredientsList = [];
  List<String> instructionsList = [];
  final RecipeService recipeService = RecipeService();
  String userId = FirebaseAuth.instance.currentUser!.uid;

  SizedBoxHeightWidth sizedboxhelper = SizedBoxHeightWidth();
  List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subtitletext('Name of Your Recipe'),
                    sizedboxhelper.kheight10,
                    NameField(
                      hintText: 'Enter your name',
                      controller: recipeNameController,
                    ),
                    sizedboxhelper.kheight10,
                    BuildTimeAndCalories(
                      onTimeAndCaloriesChanged: updateTimeAndCalories,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Category'),
                    sizedboxhelper.kheight10,
                    CategoryDropdown(
                      hintText: 'Biriyani/Friedrice/Noodles',
                      controller: recipeCategoryController,
                      categories: categories,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Difficulty'),
                    sizedboxhelper.kheight10,
                    RadioButtonsRow(
                      onDifficultyChanged: updateDifficulty,
                      difficultyText: difficultyText,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Description'),
                    sizedboxhelper.kheight10,
                    DescriptionField(controller: descriptionController),
                    sizedboxhelper.kheight10,
                    subtitletext('Ingredients'),
                    sizedboxhelper.kheight10,
                    IngredientsForm(
                      onIngredientsChanged: handleIngredientsChanged,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Instructions'),
                    sizedboxhelper.kheight10,
                    AddInstructions(onInstructionsAdded: handleInstructions),
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
                            RecipeValidator.validateRecipe(
                              context,
                              rController,
                              recipeNameController,
                              recipeCategoryController,
                              timeController,
                              caloriesController,
                              descriptionController,
                              difficultyText,
                              userId,
                              imageUrl,
                              ingredientsList,
                              instructionsList,
                            );
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
    });
  }

  void handleInstructions(List<String> instructions) {
    setState(() {
      instructionsList = instructions;
    });
  }

  Widget subtitletext(text) {
    return Text(
      text,
      style: TextSize.subtitletextsize,
    );
  }
}
