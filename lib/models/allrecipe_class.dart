class Recipes {
  String? recipeName;
  String? time;
  String? price;
  String? category;
  String? description;
  String? difficultyText;
  String? userId;
  List<String> instructions;
  List<String>? ingredients;
  String? imageUrl;

  Recipes({
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.time,
    required this.recipeName,
    required this.difficultyText,
    required this.instructions,
    required this.userId,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'time': time,
      'price': price,
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
