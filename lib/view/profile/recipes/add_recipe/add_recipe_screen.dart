import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/add_recipe.dart';
import 'package:recipe_app/controllers/premium.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
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
import 'package:recipe_app/view/profile/recipes/my_recipe_screen.dart';
import 'package:toast/toast.dart';

class AddRecipe extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>>? recipeDetail;
  const AddRecipe({Key? key, required this.recipeDetail}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final RecipeController rController = Get.put(RecipeController());
  final PremiumController premiumController = Get.put(PremiumController());

  TextEditingController recipeNameController = TextEditingController();
  TextEditingController recipeCategoryController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
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
  String recipeImageUrl = '';

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
    priceController.text = recipeDetail.data()!['calories'] ?? '';
    descriptionController.text = recipeDetail.data()!['description'] ?? '';
    difficultyController.text = recipeDetail.data()!['difficultyText'] ?? '';

    recipeImageUrl = recipeDetail.data()!['imageUrl'] ?? '';
    List<dynamic> fetchIngredients = recipeDetail.data()!['ingredients'];
    ingredientsList = List<String>.from(fetchIngredients);
    List<dynamic> fetchInstructions = recipeDetail.data()!['instructions'];
    instructionsList = List<String>.from(fetchInstructions);
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
    bool isPremiumUser = premiumController.premiumUserIds.contains(userId);
    return Scaffold(
      body: Column(
        children: [
           CustomAppBar(),
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
                        if (isPremiumUser) 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subtitletext('Est Price'),
                              sizedboxhelper.kheight10,
                              TimeField(
                                hintText: 'price',
                                controller: priceController,
                              ),
                            ],
                          )
                   
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
                    AddInstructions(
                        onInstructionsAdded: handleInstructions,
                        initialInstructions: instructionsList),
                    sizedboxhelper.kheight10,
                    subtitletext('Upload Photos'),
                    sizedboxhelper.kheight10,
                    PhotoUploadSection(
                      initialImage: recipeImageUrl,
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
                            if (widget.recipeDetail != null) {
                              String recipeId = widget.recipeDetail!.id;
                              print(':::::::::::::::::::::');
                              print(recipeId);
                              updateRecipeInFirestore(recipeId);
                            } else {
                              RecipeValidator.validateRecipe(
                                context,
                                rController,
                                recipeNameController,
                                recipeCategoryController,
                                timeController,
                                priceController,
                                descriptionController,
                                difficultyController,
                                userId,
                                imageUrl,
                                ingredientsList,
                                instructionsList,
                              );
                            }
                          },
                          child: Text(
                            widget.recipeDetail != null ? 'Update' : 'Save',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
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
      style: TextSize.subtitletext,
    );
  }

  Future<void> updateRecipeInFirestore(String recipeId) async {
    ToastContext().init(context);
    if (recipeNameController.text.isEmpty ||
        recipeCategoryController.text.isEmpty ||
        timeController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        difficultyController.text.isEmpty ||
        imageUrl.isEmpty ||
        ingredientsList.isEmpty ||
        instructionsList.isEmpty) {
      showToast(message: 'Please fill all fields');
      return;
    }
    if (!mounted) {
      return; // Return if the widget is not mounted
    }
    try {
      // Update the recipe in Firestore
      await FirebaseFirestore.instance
          .collection('add recipes')
          .doc(userId)
          .collection('recipes')
          .doc(recipeId)
          .update({
        'recipeName': recipeNameController.text,
        'category': recipeCategoryController.text,
        'time': timeController.text,
        'price': priceController.text,
        'description': descriptionController.text,
        'difficultyText': difficultyController.text,
        'imageUrl': imageUrl,
        'ingredients': ingredientsList,
        'instructions': instructionsList,
      });
      print(difficultyController.text);

      showToast(message: 'Recipe updated successfully');
    } catch (error) {
      // Handle error
      print('Failed to update recipe: $error');
      if (!mounted) {
        return; // Return if the widget is not mounted
      }
      showToast(message: 'Failed to update recipe');
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyRecipeScreen(),
      ),
    );
  }
}
