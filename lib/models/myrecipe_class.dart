class MyRecipes {
  String? recipeName;

  String imageUrl;

  MyRecipes({
    required this.imageUrl,
    required this.recipeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'imageUrl': imageUrl,
    };
  }
}
