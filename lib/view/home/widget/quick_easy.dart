import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/premium.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';
import 'package:recipe_app/widgets/user_payment.dart';

class QuickAndEasyCard extends GetView<PremiumController> {
  QuickAndEasyCard({Key? key}) : super(key: key);

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
      itemCount: controller.recipes.length,
      itemBuilder: (context, index) {
        AllRecipesList recipe = controller.recipes[index];
        return GestureDetector(
          onTap: () {
            if (controller.premiumUserIds.contains(recipe.userId)) {
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
                              style: TextSize.subtitletext,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.addToCart(
                                context,
                                controller.currentUserId!,
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
                              style: TextSize.subtitletext,
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
          child: controller.premiumUserIds.contains(recipe.userId)
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
                                      fontWeight: FontWeight.w600,
                                    ),
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
              : SizedBox(
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
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
