import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/text_strings.dart';
import 'package:recipe_app/screens/search/chef/chef_search_screen.dart';
import 'package:recipe_app/screens/search/recipe/recipe_search_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        centerTitle: true,
        title: const Text(
          'Search',
          style: TextSize.appBarTitle,
        ),
        bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Recipe'),
              Tab(text: 'Chef'),
            ],
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TabBarView(
          controller: _tabController,
          children: const [
            RecipeSearchScreen(),
            ChefSearchScreen(),
          ],
        ),
      ),
    );
  }
}
