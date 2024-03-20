import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_class.dart';

class RecipeController extends GetxController {
  RecipeService addrecipe = RecipeService();
  String userId = FirebaseAuth.instance.currentUser!.uid;


  void addRecipes(Recipes recipe) {
    Map<String, dynamic> recipeMap = recipe.toMap();
    
    addrecipe.saveRecipeToFirebase(recipeMap, userId);
  }
}
