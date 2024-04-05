import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/add_recipe.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/add_ingredients.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/add_instructions.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/category_dropdown.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/custom_appbar.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/description_section.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/difficulty.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/name_section.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/photo_upload_section.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/recipe_validator.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/widgets/time.dart';

class AddRecipe extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>>? recipeDetail;
  const AddRecipe({Key? key, required this.recipeDetail}) : super(key: key);

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
  TextEditingController difficultyController = TextEditingController();
  List<String> ingredientsController = [];
  String imageUrl = '';
  List<String> ingredientsList = [];
  List<String> instructionsList = [];
  final RecipeService recipeService = RecipeService();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  double totalHeight = 120;
  final double textFieldHeight = 60;
  final double verticalPadding = 8.0;
  SizedBoxHeightWidth sizedboxhelper = SizedBoxHeightWidth();
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    if (widget.recipeDetail != null) {
      initializeWithRecipeData(widget.recipeDetail!);
    }
    fetchCategoriesFromFirestore();
  }

  Future<void> fetchCategoriesFromFirestore() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      final List<String> fetchedCategories =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (error) {
      print('Failed to fetch categories: $error');
      // Handle error as needed
    }
  }

  void initializeWithRecipeData(
      DocumentSnapshot<Map<String, dynamic>> recipeDetail) {
    recipeNameController.text = recipeDetail.data()!['recipeName'] ?? '';
    recipeCategoryController.text = recipeDetail.data()!['category'] ?? '';
    timeController.text = recipeDetail.data()!['time'] ?? '';
    caloriesController.text = recipeDetail.data()!['calories'] ?? '';
    descriptionController.text = recipeDetail.data()!['description'] ?? '';
    difficultyController.text = recipeDetail.data()!['difficultyText'] ?? '';

    List<dynamic> fetchIngredients = recipeDetail.data()!['ingredients'];
    print('::::::::::::::::::');
    print(fetchIngredients);
    print('::::::::::::::::::');
    ingredientsList = List<String>.from(fetchIngredients);
    print(ingredientsList);
    print('::::::::::::::::::');
  }

  void addNewCategory(String newCategoryName) {
    FirebaseFirestore.instance.collection('categories').add({
      'name': newCategoryName,
    }).then((_) {
      setState(() {
        categories.add(newCategoryName);
      });
    }).catchError((error) {
      print('Failed to add category: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    print(categories);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitletext('Est Time'),
                            sizedboxhelper.kheight10,
                            TimeField(
                                hintText: 'in minutes',
                                controller: timeController),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitletext('Calories'),
                            sizedboxhelper.kheight10,
                            TimeField(
                                hintText: 'calories',
                                controller: caloriesController),
                          ],
                        ),
                      ],
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Category'),
                    sizedboxhelper.kheight10,
                    CategoryDropdown(
                      hintText: 'Select Category',
                      controller: recipeCategoryController,
                      categories: categories,
                      onNewCategoryAdded: addNewCategory,
                    ),
                    sizedboxhelper.kheight10,
                    subtitletext('Difficulty'),
                    sizedboxhelper.kheight10,
                    DifficultyDropDown(
                      hintText: 'choose one',
                      controller: difficultyController,
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
                      initialIngredients: ingredientsList,
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
                              difficultyController,
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
