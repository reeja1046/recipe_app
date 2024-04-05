import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:recipe_app/models/myrecipe_class.dart';

class UserRecipeController extends GetxController {
  UserRecipeController({required this.userId});
  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('add recipes');
  final RxList<MyRecipes> recipes = <MyRecipes>[].obs;

  late String userId;

  @override
  void onInit() {
    print(userId);
    print('%%##############');
    super.onInit();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    print('%%%****************%%%%%%%');
    print(userId);
    try {
      recipesCollection
          .doc(userId)
          .collection('recipes')
          .snapshots()
          .listen((snapshot) {
        print(snapshot.docs);
        print('--------------------------------');
        recipes.assignAll(
          snapshot.docs.map((doc) {
            String recipeId = doc.id;
            print(recipeId);
            return MyRecipes(
              recipeId: recipeId,
              imageUrl: doc['imageUrl'] ?? 'assets/placeholder.jpg',
              recipeName: doc['recipeName'] ?? '',
            );
          }),
        );
      });
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }
}
