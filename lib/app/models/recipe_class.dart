class Recipes {
  String? recipeName;
  String? etsTime;
  String? calories;
  String? category;
  String? difficultyLevel;
  String? description;
  List<String>? ingredients;
  String imageUrl;

  Recipes(
      {required this.imageUrl,
      required this.calories,
      required this.category,
      required this.difficultyLevel,
      required this.description,
      required this.ingredients,
      required this.etsTime,
      required this.recipeName});
}
