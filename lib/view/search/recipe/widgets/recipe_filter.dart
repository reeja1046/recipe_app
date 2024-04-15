import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:toast/toast.dart';

class RecipeFilterScreen extends StatefulWidget {
  const RecipeFilterScreen({Key? key}) : super(key: key);

  @override
  State<RecipeFilterScreen> createState() => _RecipeFilterScreenState();
}

class _RecipeFilterScreenState extends State<RecipeFilterScreen> {
  String? selectedCategory;
  String? selectedTime;
  String? selectedLevel;
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'Search Filters',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        final categories = snapshot.data!.docs;

                        return Wrap(
                          spacing: 30,
                          children: categories.map((category) {
                            final categoryName = category['name'] as String;
                            return OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = categoryName;
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  selectedCategory == categoryName
                                      ? AppColor.baseColor
                                      : Colors.white,
                                ),
                              ),
                              child: Text(
                                categoryName,
                                style: TextStyle(
                                  color: selectedCategory == categoryName
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Time to Cook',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(
                        labelText: 'Enter the max time you have',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: AppColor.baseColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: AppColor.baseColor),
                        ),
                        contentPadding: const EdgeInsets.only(left: 15),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Difficulty',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedLevel = 'Easy';
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                selectedLevel == 'Easy'
                                    ? AppColor.baseColor
                                    : Colors.white,
                              ),
                            ),
                            child: Text(
                              'Easy',
                              style: TextStyle(
                                color: selectedLevel == 'Easy'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedLevel = 'Medium';
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                selectedLevel == 'Medium'
                                    ? AppColor.baseColor
                                    : Colors.white,
                              ),
                            ),
                            child: Text(
                              'Medium',
                              style: TextStyle(
                                color: selectedLevel == 'Medium'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedLevel = 'Hard';
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                selectedLevel == 'Hard'
                                    ? AppColor.baseColor
                                    : Colors.white,
                              ),
                            ),
                            child: Text(
                              'Hard',
                              style: TextStyle(
                                color: selectedLevel == 'Hard'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                selectedTime = timeController.value.toString();
                List<AllRecipesList>? filteredRecipes = await filterRecipes(
                  selectedCategory!,
                  selectedLevel,
                  selectedTime,
                );
                Get.back(result: filteredRecipes);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: const Text(
                'Find Recipes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<AllRecipesList>?> filterRecipes(
    String category,
    String? difficultyLevel,
    String? estimatedTimeStr,
  ) async {
    print(category);
    print(difficultyLevel);
    print(estimatedTimeStr);
    ToastContext().init(context);
    final List<AllRecipesList>? recipes = await RecipeService().getAllRecipes();
    List<AllRecipesList>? filteredRecipes = [];

    if (recipes != null) {
      int? estimatedTime =
          estimatedTimeStr != null ? int.tryParse(estimatedTimeStr) : null;

      for (var recipe in recipes) {
        int estTimeInt = int.tryParse(recipe.time ?? '') ?? 0;
        if (recipe.category == category &&
            (estimatedTime == null || estTimeInt <= estimatedTime) &&
            (difficultyLevel == null ||
                recipe.difficultyLevel == difficultyLevel)) {
          filteredRecipes.add(AllRecipesList(
            recipeId: recipe.recipeId,
            recipeName: recipe.recipeName,
            imageUrl: recipe.imageUrl,
            userId: recipe.userId,
            category: recipe.category,
            time: recipe.time,
            difficultyLevel: recipe.difficultyLevel,
            price: '',
          ));
        }
      }

      if (filteredRecipes.isNotEmpty) {
        print('Recipes in category $category:');
        for (var recipe in filteredRecipes) {
          print('Recipe: ${recipe.recipeName}, UserId: ${recipe.userId}');
        }
      } else {
        showToast(
            message:
                'No recipes found in category $category with the specified criteria.');
      }
    } else {
      showToast(message: 'No recipes found.');
    }

    return filteredRecipes;
  }
}
