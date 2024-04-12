import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_search.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

// ignore: must_be_immutable
class RecipeSearchScreen extends StatelessWidget {
  RecipeSearchScreen({super.key});

  final RecipeSearchController controller = Get.put(RecipeSearchController());
  SizedBoxHeightWidth kHeightWidth = SizedBoxHeightWidth();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                labelText: 'Search',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: AppColor.subBlackColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: AppColor.subBlackColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(left: 15),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: AppColor.subGreyColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: AppColor.subGreyColor,
                                  ),
                                  onPressed: () {
                                    controller.searchController.clear();
                                    controller.filterRecipes('');
                                  },
                                ),
                              ),
                              onChanged: controller.filterRecipes,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kHeightWidth.kWidth10,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.subBlackColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 40,
                  width: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: controller.navigateToFilterScreen,
                      child: Image.asset(
                        'assets/filter.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            kHeightWidth.kheight10,
            const Text(
              'All Recipes',
              style: TextSize.subtitletext,
            ),
            kHeightWidth.kheight10,
            controller.filteredRecipes.isEmpty
                ? const Center(
                    child: Column(
                      children: [
                        Image(image: AssetImage('assets/searchicon.jpg')),
                        Text(
                          'No Recipes Found',
                          style: TextStyle(
                              color: AppColor.subGreyColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: controller.filteredRecipes.length,
                    itemBuilder: (context, index) {
                      AllRecipesList recipe = controller.filteredRecipes[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => DetailedRecipeScreen(
                                recipeId: recipe.recipeId!,
                                userId: recipe.userId!,
                              ));
                        },
                        child: Card(
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
                                  color: AppColor.subBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
