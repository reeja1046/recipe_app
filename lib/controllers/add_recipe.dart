
import 'package:get/get.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_class.dart';

class RecipeController extends GetxController {
  RecipeService addrecipe = RecipeService();

  void addRecipes(Recipes recipe,userId) {
    Map<String, dynamic> recipeMap = recipe.toMap();

    addrecipe.saveRecipeToFirebase(recipeMap, userId);
  }
}
