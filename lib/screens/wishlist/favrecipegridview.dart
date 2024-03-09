import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class FavRecipeGridView extends StatelessWidget {
  const FavRecipeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    List<RecipeCard> recipeCards = [
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
      RecipeCard(
        recipeName: 'Beef Biriyani',
        calories: 24,
        cookingTime: '30 min',
        imageUrl: 'assets/Beef FR.jpg',
      ),
    ];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: recipeCards.length,
      itemBuilder: (BuildContext context, int index) {
        return RecipeCardItem(recipeCard: recipeCards[index]);
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
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String recipeName;
  final int calories;
  final String cookingTime;
  final String imageUrl;

  // ignore: prefer_const_constructors_in_immutables
  RecipeCard({
    super.key,
    required this.recipeName,
    required this.calories,
    required this.cookingTime,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                imageUrl,
                height: 100,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeName,
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
                            Text('$calories'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              size: 18,
                            ),
                            Text(cookingTime),
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
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
