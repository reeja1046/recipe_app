import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/models/user_class.dart';
import 'package:recipe_app/view/profile/recipes/add_recipe/add_recipe_screen.dart';
import 'package:recipe_app/view/search/chef/widgets/chef_profile.dart';
import 'package:recipe_app/widgets/ingredients.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class DetailedRecipeScreen extends StatelessWidget {
  final String recipeId; // Pass the recipe ID to the screen
  final String userId;
  DetailedRecipeScreen({Key? key, required this.recipeId, required this.userId})
      : super(key: key);

  final SizedBoxHeightWidth sizeBoxHelper = SizedBoxHeightWidth();

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<MyUsers?> fetchUserDetails(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('user_profile')
          .doc(userId)
          .get();
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      if (userData != null && userData.isNotEmpty) {
        String? userName = userData['UserName'];
        String? imageUrl = userData['UserProfileImage'];

        print('::::::::::::::::::::::::::');
        print(userName);
        return MyUsers(userId: userId, imageUrl: imageUrl, userName: userName);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(recipeId);
    print(currentUserId);
    print(userId);
    print('*********----------***********');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipe Details'),
        actions: [
          if (currentUserId == userId)
            IconButton(
                onPressed: () {
                  fetchRecipeDetails();
                },
                icon: const Icon(Icons.edit))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('add recipes')
            .doc(userId)
            .collection('recipes')
            .doc(recipeId)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Recipe not found'));
          }

          final Map<String, dynamic> recipeData =
              snapshot.data!.data() as Map<String, dynamic>;
          print(recipeData);

          final List<String> ingredients =
              List<String>.from(recipeData['ingredients'] ?? []);
          final List<String> instructions =
              List<String>.from(recipeData['instructions'] ?? []);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          recipeData['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          addToFavorites(context, currentUserId, recipeData,
                              userId, recipeId);
                        },
                        icon: const Icon(Icons.favorite_border_outlined),
                        iconSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Colors.white,
                          ),
                          Text(
                            '${recipeData['time']}',
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                sizeBoxHelper.kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${recipeData['recipeName']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      '${recipeData['difficultyText']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    )
                  ],
                ),
                sizeBoxHelper.kheight10,
                if (currentUserId != userId)
                  Container(
                    child: FutureBuilder<MyUsers?>(
                      future: fetchUserDetails(userId),
                      builder: (BuildContext context,
                          AsyncSnapshot<MyUsers?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasData) {
                          MyUsers user = MyUsers(
                            userId: userId,
                            imageUrl: snapshot.data!.imageUrl ?? '',
                            userName: snapshot.data!.userName ?? '',
                          );
                          return InkWell(
                            onTap: () => Get.to(
                              () => ChefProfile(
                                user: user,
                              ),
                            ),
                            child: Text(
                              'Chef: ${snapshot.data!.userName}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          );
                        } else {
                          return const Text('Chef: Unknown');
                        }
                      },
                    ),
                  ),
                sizeBoxHelper.kheight10,
                Text(
                  '${recipeData['description']}',
                ),
                sizeBoxHelper.kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ingredients :',
                      style: TextSize.subtitletext,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IngredientsScreen()));
                      },
                      child: const Text(
                        'Click here',
                        style: TextStyle(color: AppColor.baseColor),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.circle,
                        size: 10,
                      ),
                      title: Text(ingredients[index]),
                    );
                  },
                ),
                sizeBoxHelper.kheight10,
                const Text(
                  'Instructions',
                  style: TextSize.subtitletext,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: instructions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.circle,
                        size: 10,
                      ),
                      title: Text(instructions[index]),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void addToFavorites(BuildContext context, String currentUserId,
      Map<String, dynamic> recipeData, String userId, String recipeId) {
    ToastContext().init(context);
    final favoritesRef = FirebaseFirestore.instance
        .collection('add recipes')
        .doc(currentUserId)
        .collection('favorites'); // Reference to the favorites collection

    final recipeName = recipeData['recipeName'];
    recipeData['userId'] = userId;
    recipeData['recipeId'] = recipeId;

    // Check if the recipe already exists in the favorites collection
    favoritesRef.doc(recipeName).get().then((docSnapshot) {
      if (docSnapshot.exists) {
        showToast(message: 'Recipe already exists in favorites!');
        print('Recipe already exists in favorites!');
      } else {
        // Add the recipe to favorites collection with the recipe name as the document name
        favoritesRef.doc(recipeName).set(recipeData).then((_) {
          showToast(message: 'Recipe added to favorites!');
          print('Recipe added to favorites!');
        }).catchError((error) {
          showToast(message: 'Failed to add recipe to favorites: $error');
        });
      }
    }).catchError((error) {
      showToast(message: 'Error checking recipe in favorites: $error');
    });
  }

  fetchRecipeDetails() async {
    print('^^^^^^^^^&&&&&&&&&&^^^^^^');
    print(recipeId);
    var recipeDetail = await FirebaseFirestore.instance
        .collection('add recipes')
        .doc(userId)
        .collection('recipes')
        .doc(recipeId)
        .get();
    print(recipeDetail.data());
    var instruction = recipeDetail.data()!['instructions'];
    print(instruction);
    if (recipeDetail.data() != null) {
      Get.to(() => AddRecipe(recipeDetail: recipeDetail));
    }
  }
}
