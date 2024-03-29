class Recipes {
  String? recipeName;
  String? etsTime;
  String? calories;
  String? category;
  String? description;
  String? difficultyText;
  String? userId;
  List<String> instructions;
  List<String>? ingredients;
  String? imageUrl;

  Recipes(
      {required this.imageUrl,
      required this.calories,
      required this.category,
      required this.description,
      required this.ingredients,
      required this.etsTime,
      required this.recipeName,
      required this.difficultyText,
      required this.instructions,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'etsTime': etsTime,
      'calories': calories,
      'category': category,
      'difficultyText': difficultyText,
      'description': description,
      'id': userId,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
      'instructions': instructions,
    };
  }
}

