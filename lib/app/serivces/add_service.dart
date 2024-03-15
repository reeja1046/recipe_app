import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveRecipeToFirebase(
    Map<String, dynamic> recipeData,
  ) async {
    try {
      // Save the recipe data to Firestore
      await firestore
          .collection('add_recipes')
          .add(recipeData)
          .then((value) => {print("Recipe added with ID : ${value.id}")});
      print('Recipe saved to Firebase');
    } catch (e) {
      print('Error saving recipe: $e');
    }
  }
}
