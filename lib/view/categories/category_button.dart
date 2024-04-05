import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/view/categories/category_card.dart';
import 'package:toast/toast.dart';

class CategoryButtons extends StatefulWidget {
  const CategoryButtons({Key? key}) : super(key: key);

  @override
  _CategoryButtonsState createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  String? selectedCategory;
  late Future<List<String>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = fetchCategories();
  }

  Future<List<String>> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      List<String> categories =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      if (selectedCategory == null && categories.isNotEmpty) {
        selectedCategory = categories.first;
      }

      return categories;
    } catch (error) {
      throw Exception('Failed to fetch categories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String> categories = snapshot.data ?? [];
          return Row(
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: CategoryButton(
                  text: category,
                  onPressed: () {
                    print(category);
                    selectCategory(category);
                  },
                  isSelected: selectedCategory == category,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  void selectCategory(String category) {
    print(category);
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    setState(() {
      selectedCategory = category;
    });

    fetchRecipes(selectedCategory);
  }

  fetchRecipes(selectedCategory) async {
    ToastContext().init(context);
    print(selectedCategory);
    final List<AllRecipesList> fetchedRecipes =
        await RecipeService().getAllRecipes();
    print(fetchedRecipes.length);
    print('&&&&&&&&&****************&&&&&&&&&&&&');
    List<AllRecipesList> filteredRecipes = [];
    if (fetchedRecipes != null) {
      for (var recipe in fetchedRecipes) {
        if (recipe.category == selectedCategory) {
          filteredRecipes.add(
            AllRecipesList(
              recipeId: recipe.recipeId,
              recipeName: recipe.recipeName,
              imageUrl: recipe.imageUrl,
              userId: recipe.userId,
              category: recipe.category,
              time: recipe.time,
              difficultyLevel: recipe.difficultyLevel,
              calories: '',
            ),
          );
        }
      }
      if (filteredRecipes.isNotEmpty) {
        print('Recipes in category $selectedCategory:');
        for (var recipe in filteredRecipes) {
          print('Recipe: ${recipe.recipeName}, UserId: ${recipe.userId}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryCard(
                filteredRecipes: filteredRecipes,
              ),
            ),
          );
        }
      } else {
        showToast(message: 'No recipes found in category $selectedCategory');
      }
    } else {
      showToast(message: 'No recipes found.');
    }
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const CategoryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side:
              BorderSide(color: isSelected ? Colors.white : AppColor.baseColor),
          backgroundColor: isSelected ? AppColor.baseColor : Colors.transparent,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
