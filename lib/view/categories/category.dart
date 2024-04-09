import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/view/categories/category_button.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<AllRecipesList>? recipes;

  @override
  void initState() {
    fetchRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      height: 35,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColor.baseColor),
                          backgroundColor: AppColor.baseColor,
                        ),
                        onPressed: () => fetchRecipes(),
                        child: const Text(
                          'All',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const CategoryButtons(),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: recipes?.length ?? 0,
                  itemBuilder: (context, index) {
                    AllRecipesList recipe = recipes![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailedRecipeScreen(
                              recipeId: recipe.recipeId!,
                              userId: recipe.userId!,
                            ),
                          ),
                        );
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchRecipes() async {
    final List<AllRecipesList> fetchedRecipes =
        await RecipeService().getAllRecipes();
    setState(() {
      recipes = fetchedRecipes;
    });
  }
}
