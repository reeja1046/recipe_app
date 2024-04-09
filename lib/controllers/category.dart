import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';

class CategoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<AllRecipesList> recipes = <AllRecipesList>[].obs;
  RxBool isPremium = false.obs;
  String? currentUserId;

  @override
  void onInit() {
    fetchRecipes();
    checkUserPremiumStatus();
    super.onInit();
  }

  Future<void> fetchRecipes() async {
    final List<AllRecipesList> fetchedRecipes =
        await RecipeService().getAllRecipes();
    recipes.value = fetchedRecipes;
  }

  void addToCart(String currentUserId, Map<String, dynamic> recipeData,
      String userId, String recipeId, String imageUrl) async {
    final myCartRef = _firestore
        .collection('add recipes')
        .doc(currentUserId)
        .collection('my cart');

    final recipeName = recipeData['recipeName'];
    recipeData['userId'] = userId;
    recipeData['recipeId'] = recipeId;
    recipeData['imageUrl'] = imageUrl;

    try {
      final docSnapshot = await myCartRef.doc(recipeName).get();
      if (docSnapshot.exists) {
        showToast(message: 'Recipe already exists in my cart!');
        print('Recipe already exists in my cart!');
      } else {
        await myCartRef.doc(recipeName).set(recipeData);
        showToast(message: 'Recipe added to my cart!');
        print('Recipe added to my cart!');
      }
    } catch (error) {
      showToast(message: 'Error checking recipe in my cart: $error');
    }
  }

  Future<void> checkUserPremiumStatus() async {
    try {
      currentUserId = _auth.currentUser?.uid;
      if (currentUserId != null) {
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('premium')
            .where('userId', isEqualTo: currentUserId)
            .get();

        isPremium.value = snapshot.docs.isNotEmpty;
      }
    } catch (error) {
      print('Error checking premium status: $error');
    }
  }
  
  bool isRecipeOwnedByPremiumUser(AllRecipesList recipe) {
    return isPremium.value && recipe.userId == currentUserId;
  }
}
