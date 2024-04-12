import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class FavRecipeGridView extends StatelessWidget {
  const FavRecipeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('add recipes')
          .doc(currentUserId)
          .collection('favorites')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(
            child: Text(
              'No favorite recipes found.',
              style: TextSize.subtitletext,
            ),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            final recipeData = docs[index].data() as Map<String, dynamic>;
            return RecipeCard(
              recipeName: recipeData['recipeName'],
              calories: recipeData['calories'],
              cookingTime: recipeData['etsTime'],
              imageUrl: recipeData['imageUrl'],
              recipeId: recipeData['recipeId'],
              userId: recipeData['userId'],
            );
          },
        );
      },
    );
  }
}

class RecipeCardItem extends StatelessWidget {
  final RecipeCard recipeCard;

  const RecipeCardItem({super.key, required this.recipeCard});

  @override
  Widget build(BuildContext context) {
    return RecipeCard(
      recipeName: recipeCard.recipeName,
      calories: recipeCard.calories,
      cookingTime: recipeCard.cookingTime,
      imageUrl: recipeCard.imageUrl,
      recipeId: recipeCard.recipeId,
      userId: recipeCard.userId,
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String? recipeName;
  final String? calories;
  final String? cookingTime;
  final String? imageUrl;
  final String? recipeId;
  final String? userId;

  RecipeCard({
    Key? key,
    required this.recipeName,
    required this.calories,
    required this.cookingTime,
    required this.imageUrl,
    required this.recipeId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          print('tapped on recipe');
          // Navigate to detailed recipe page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedRecipeScreen(
                recipeId: recipeId!,
                userId: userId!,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            if (imageUrl != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    imageUrl!,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipeName ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/colorie.png',
                                  color: AppColor.baseColor,
                                  height: 20,
                                  width: 20,
                                ),
                                Text(calories ?? ''),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  size: 18,
                                ),
                                Text(cookingTime ?? ''),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  // Remove recipe from favorites collection
                  FirebaseFirestore.instance
                      .collection('add recipes')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('favorites')
                      .where('recipeName', isEqualTo: recipeName)
                      .get()
                      .then((querySnapshot) {
                    for (var doc in querySnapshot.docs) {
                      doc.reference.delete();
                    }
                  }).then((_) {
                    print('Recipe removed from favorites');
                  }).catchError((error) {
                    print('Failed to remove recipe: $error');
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
