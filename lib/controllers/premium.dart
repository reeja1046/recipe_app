// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/models/myrecipe_class.dart';
import 'package:toast/toast.dart';

class PremiumController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('add recipes');
  RecipeService recipeService = RecipeService();

  RxList<AllRecipesList> recipes = <AllRecipesList>[].obs;
  RxBool isPremium = false.obs;
  String? currentUserId;
 late List<String> premiumUserIds = [];

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

    List<AllRecipesList> filteredRecipes = [];

    for (var recipe in fetchedRecipes) {
      int? estTimeInt = int.tryParse(recipe.time ?? '');
      if (estTimeInt != null && estTimeInt < 30) {
        filteredRecipes.add(recipe);
      }
    }

    recipes.value = filteredRecipes;
  }

  void addToCart(
    BuildContext context,
    String currentUserId,
    Map<String, dynamic> recipeData,
    String userId,
    String recipeId,
    String imageUrl,
  ) async {
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
        Navigator.of(context).pop();
        print('Recipe already exists in my cart!');
      } else {
        await myCartRef.doc(recipeName).set(recipeData);
        showToast(message: 'Recipe added to my cart!');
        Navigator.of(context).pop();
        print('Recipe added to my cart!');
      }
    } catch (error) {
      showToast(message: 'Error checking recipe in my cart: $error');
      Navigator.of(context).pop();
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
        print('::::::::::::');
        print(isPremium.value);
        print('::::::::::::');
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
