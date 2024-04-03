import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/models/allrecipe_list.dart';
import 'package:recipe_app/view/search/recipe/widgets/recipe_filter.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class RecipeSearchScreen extends StatefulWidget {
  const RecipeSearchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  late TextEditingController _searchController;
  late List<AllRecipesList> _allRecipes;
  late List<AllRecipesList> _filteredRecipes;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _allRecipes = [];
    _filteredRecipes = [];
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    final List<AllRecipesList>? recipes = await RecipeService().getAllRecipes();
    if (recipes != null) {
      setState(() {
        _allRecipes = recipes;
        _filteredRecipes = _allRecipes;
      });
    }
  }

  void _filterRecipes(String query) {
    setState(() {
      _filteredRecipes = _allRecipes
          .where((recipe) =>
              recipe.recipeName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToFilterScreen() async {
    List<AllRecipesList>? filteredRecipes =
        await Get.to(() => RecipeFilterScreen());
    print(filteredRecipes);
    print('99999999999900000000088888888');
    if (filteredRecipes != null) {
      setState(() {
        _filteredRecipes = filteredRecipes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Search',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.only(left: 15),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              suffixIcon: IconButton(
                                icon:
                                    const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              ),
                            ),
                            onChanged: _filterRecipes,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 40,
                width: 40,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: _navigateToFilterScreen,
                    child: Image.asset(
                      'assets/filter.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'All Recipes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          _filteredRecipes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: _filteredRecipes.length,
                  itemBuilder: (context, index) {
                    AllRecipesList recipe = _filteredRecipes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailedRecipeScreen(
                                  recipeId: recipe.recipeId!,
                                  userId: recipe.userId!,
                                )));
                      },
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black45,
                          title: Text(
                            recipe.recipeName ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        child: Image.network(
                          recipe.imageUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
          // if (_filteredRecipes.isEmpty)
          //   const Center(
          //     child: Text(
          //       'No Result Found',
          //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //     ),
          //   ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
