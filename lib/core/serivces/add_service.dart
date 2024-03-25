import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/models/allrecipe_list.dart';

class RecipeService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveRecipeToFirebase(
      Map<String, dynamic> recipeData, String userId) async {
    try {
      print(userId);
      // Save the recipe data to Firestore
      await firestore
          .collection('add recipes')
          .doc(userId)
          .collection('recipes')
          .add(recipeData)
          .then((value) => {print("Recipe added")});
      print('Recipe saved to Firebase');
    } catch (e) {
      print('Error saving recipe: $e');
    }
  }

    Future<List<MyAllRecipes>> getAllRecipes() async {
    List<MyAllRecipes> recipes = [];

    try {
      QuerySnapshot querySnapshot = await firestore.collectionGroup('recipes').get();

      querySnapshot.docs.forEach((doc) {
        recipes.add(MyAllRecipes.fromFirestore(doc));
        print(recipes);
      });

      return recipes;
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }

  Future<void> saveUserDetailsToFirebase(
      Map<String, dynamic> userData, userId) async {
    try {
      await firestore.collection('user_profile').doc(userId).set(userData);
      //.then((value) => {print("User added  with ID : ${value.id}")});
      showToast(message: 'User Data saved to firebase');
    } catch (e) {
      print('Error Occured');
    }
  }

  Future<bool> doesUserIdExist(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user_profile')
          .where('UserId', isEqualTo: userId)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print('Error checking if user ID exists: $error');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('user_profile').doc(userId).get();
      print(userId);
      print(userSnapshot.data());
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        print('User data retrieved successfully: $userData');
        return userData;
      } else {
        print('Document does not exist for userId: $userId');
        return null;
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }
}
