import 'package:cloud_firestore/cloud_firestore.dart';

class AllRecipesList {
  String? recipeName;
  String? recipeId;
  String? imageUrl;
  String? userId;
  String? category;
  String? time;
  String? difficultyLevel;
  String? price;

  AllRecipesList(
      {required this.recipeId,
      required this.imageUrl,
      required this.recipeName,
      required this.userId,
      required this.category,
      required this.difficultyLevel,
      required this.time,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'imageUrl': imageUrl,
      'recipeId': recipeId,
      'id': userId,
      'time': time,
      'difficultyText': difficultyLevel,
      'price': price,
    };
  }

  factory AllRecipesList.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    print('111111111111112222222222222');
    return AllRecipesList(
        recipeId: doc.id,
        imageUrl: data['imageUrl'] ?? 'defaultImageUrl',
        recipeName: data['recipeName'] ?? 'Unnamed Recipe',
        userId: data['id'] ?? 'defaultUserId',
        category: data['category'] ?? 'Unknown',
        difficultyLevel: data['difficultyText'] ?? 'Unknown',
        time: data['time'] ?? 'Unknown',
        price: data['price'] ?? '0');
  }
}
