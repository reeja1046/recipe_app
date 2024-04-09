import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/models/myrecipe_class.dart';
import 'package:toast/toast.dart';

class CategoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late List<String> premiumUserIds = [];
  RxList<AllRecipesList> recipes = <AllRecipesList>[].obs;
  RxBool isPremium = false.obs;
  String? currentUserId;

  RecipeService recipeService = RecipeService();

  @override
  void onInit() {
    fetchRecipes();
    fetchRecipesByPremiumUsers();
    checkUserPremiumStatus();
    super.onInit();
  }

  Future<void> fetchRecipes() async {
    final List<AllRecipesList> fetchedRecipes =
        await RecipeService().getAllRecipes();
    recipes.value = fetchedRecipes;
  }

  void addToCart(
    BuildContext context,String currentUserId, Map<String, dynamic> recipeData,
      String userId, String recipeId, String imageUrl) async {
    ToastContext().init(context);
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

  Future<List<String>> fetchUserIdsFromPremium() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('premium').get();

      premiumUserIds =
          querySnapshot.docs.map((doc) => doc['userId'] as String).toList();

      print(premiumUserIds);
      print('-------------------==============-----------');
      return premiumUserIds;
    } catch (error) {
      throw Exception('Failed to fetch premium users: $error');
    }
  }

  Future<List<MyRecipes>> fetchRecipesByPremiumUsers() async {
    try {
      // Fetch premium user IDs
      List<String> premiumUserIds = await fetchUserIdsFromPremium();

      List<MyRecipes> premiumRecipes = [];
      for (String userId in premiumUserIds) {
        List<MyRecipes> userRecipes =
            await recipeService.fetchRecipesByUserId(userId);

        premiumRecipes.addAll(userRecipes);
      }
      print(premiumRecipes.length);
      print('-----------------+++++++++++++++++++');
      return premiumRecipes;
    } catch (error) {
      throw Exception('Failed to fetch recipes by premium users: $error');
    }
  }
}
