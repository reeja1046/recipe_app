import 'package:cloud_firestore/cloud_firestore.dart';

class MyAllRecipes {
  String? recipeName;
  String? recipeId;
  String? imageUrl;
  String? userId;

  MyAllRecipes({
    required this.recipeId,
    required this.imageUrl,
    required this.recipeName,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'imageUrl': imageUrl,
      'recipeId': recipeId,
      'id': userId,
    };
  }

  factory MyAllRecipes.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    print('111111111111112222222222222');
    return MyAllRecipes(
      recipeId: doc.id,
      imageUrl: data['imageUrl'] ?? 'defaultImageUrl',
      recipeName: data['recipeName'] ?? 'Unnamed Recipe',
      userId: data['id'] ?? 'defaultUserId',
    );
  }
}
