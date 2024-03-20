import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:recipe_app/models/myrecipe_class.dart';

class MyRecipeController extends GetxController {
  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('add recipes');
  final RxList<MyRecipes> recipes = <MyRecipes>[].obs;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      final QuerySnapshot snapshot =
          await recipesCollection.doc(userId).collection('recipes').get();
      recipes.assignAll(snapshot.docs.map((doc) => MyRecipes(
            imageUrl: doc['imageUrl'] ?? 'assets/placeholder.jpg',
            recipeName: doc['recipeName'] ?? '',
          )));
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }
}
