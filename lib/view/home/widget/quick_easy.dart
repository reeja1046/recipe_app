import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/widgets/user_payment.dart';
import 'package:toast/toast.dart';

class QuickAndEasyCard extends StatefulWidget {
  const QuickAndEasyCard({Key? key}) : super(key: key);

  @override
  State<QuickAndEasyCard> createState() => _QuickAndEasyCardState();
}

class _QuickAndEasyCardState extends State<QuickAndEasyCard> {
  List<AllRecipesList> recipes = [];
  List<AllRecipesList> cartRecipes = [];
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  bool isPremium = false;

  @override
  void initState() {
    fetchRecipes();
    checkUserPremiumStatus();
    super.initState();
  }

  Future<void> fetchRecipes() async {
    final List<AllRecipesList> fetchedRecipes =
        await RecipeService().getAllRecipes();

    List<AllRecipesList> filteredRecipes = [];

    for (var recipe in fetchedRecipes) {
      int? estTimeInt = int.tryParse(recipe.time ?? '');
      if (estTimeInt != null && estTimeInt < 30) {
        filteredRecipes.add(recipe);
      }
    }

    setState(() {
      recipes = filteredRecipes;
    });
  }

  void addToCart(
      BuildContext context,
      String currentUserId,
      Map<String, dynamic> recipeData,
      String userId,
      String recipeId,
      String imageUrl) {
    ToastContext().init(context);
    final myCartRef = FirebaseFirestore.instance
        .collection('add recipes')
        .doc(currentUserId)
        .collection('my cart');

    final recipeName = recipeData['recipeName'];
    recipeData['userId'] = userId;
    recipeData['recipeId'] = recipeId;
    recipeData['imageUrl'] = imageUrl;

    myCartRef.doc(recipeName).get().then((docSnapshot) {
      if (docSnapshot.exists) {
        showToast(message: 'Recipe already exists in my cart!');
        Navigator.of(context).pop();
        print('Recipe already exists in my cart!');
      } else {
        myCartRef.doc(recipeName).set(recipeData).then((_) {
          showToast(message: 'Recipe added to my cart!');
          Navigator.of(context).pop();
          print('Recipe added to my cart!');
        }).catchError((error) {
          showToast(message: 'Failed to add recipe to my cart: $error');
          Navigator.of(context).pop();
        });
      }
    }).catchError((error) {
      showToast(message: 'Error checking recipe in my cart: $error');
      Navigator.of(context).pop();
    });
  }

  Future<void> checkUserPremiumStatus() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('premium')
            .where('userId', isEqualTo: userId)
            .get();
        setState(() {
          isPremium = snapshot.docs.isNotEmpty;
        });
      }
    } catch (error) {
      print('Error checking premium status: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        AllRecipesList recipe = recipes[index];
        bool isRecipePremium = isPremium &&
            recipe.userId == FirebaseAuth.instance.currentUser?.uid;

        return GestureDetector(
          onTap: () {
            if (isRecipePremium) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Want to buy it?'),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => const UserPaymentScreen());
                            },
                            child: const Text(
                              'Pay Now',
                              style: TextSize.subtitletextsize,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              addToCart(
                                context,
                                currentUserId!,
                                {
                                  'recipeName': recipe.recipeName,
                                },
                                recipe.userId!,
                                recipe.recipeId!,
                                recipe.imageUrl!,
                              );
                            },
                            child: const Text(
                              'Add to Cart',
                              style: TextSize.subtitletextsize,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailedRecipeScreen(
                    recipeId: recipe.recipeId!,
                    userId: recipe.userId!,
                  ),
                ),
              );
            }
          },
          child: isRecipePremium
              ? SizedBox(
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                recipe.imageUrl ?? '',
                                fit: BoxFit.cover,
                                height: 130,
                              ),
                            ),
                            Text(
                              recipe.recipeName ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (isRecipePremium)
                          Positioned.fill(
                            child: Container(
                              color: Colors.grey.withOpacity(0.7),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock),
                                    SizedBox(width: 4),
                                    Text(
                                      'Buy to Unlock',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          recipe.imageUrl ?? '',
                          fit: BoxFit.cover,
                          height: 130,
                        ),
                      ),
                      Text(
                        recipe.recipeName ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
