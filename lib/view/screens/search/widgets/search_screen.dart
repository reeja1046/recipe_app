import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/search/chef/chef_search_screen.dart';
import 'package:recipe_app/view/screens/search/recipe/recipe_search_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  String _currentTab = 'Recipe';
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
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'Search',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
