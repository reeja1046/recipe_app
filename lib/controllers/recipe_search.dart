import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/view/search/recipe/widgets/recipe_filter.dart';

class RecipeSearchController extends GetxController {
  var searchController = TextEditingController();
  var allRecipes = <AllRecipesList>[].obs;
  var filteredRecipes = <AllRecipesList>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  void fetchRecipes() async {
    List<AllRecipesList>? recipes = await RecipeService().getAllRecipes();
    if (recipes != null) {
      allRecipes.assignAll(recipes);
      filteredRecipes.assignAll(allRecipes);
    }
  }

  void filterRecipes(String query) {
    filteredRecipes.value = allRecipes
        .where((recipe) => recipe.recipeName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> navigateToFilterScreen() async {
    // Navigate to filter screen and get filtered recipes
    // Example implementation using GetX navigation
    var result = await Get.to(() => RecipeFilterScreen()) as List<AllRecipesList>?;
    if (result != null) {
      filteredRecipes.assignAll(result);
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
