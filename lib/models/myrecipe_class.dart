class MyRecipes {
  String? recipeName;
  String? recipeId;
  String? imageUrl;

  MyRecipes({
    required this.recipeId,
    required this.imageUrl,
    required this.recipeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'imageUrl': imageUrl,
      'recipeId': recipeId,
    };
  }

}
