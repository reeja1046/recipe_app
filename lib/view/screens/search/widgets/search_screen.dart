// import 'package:flutter/material.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _currentTab = 'Recipe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentTab = 'Recipe';
                });
              },
              child: Text(
                'Recipe',
                style: TextStyle(
                  color: _currentTab == 'Recipe' ? Colors.white : Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentTab = 'Chef';
                });
              },
              child: Text(
                'Chef',
                style: TextStyle(
                  color: _currentTab == 'Chef' ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _currentTab == 'Recipe' ? const RecipeSearchScreen() : ChefSearchScreen(),
    );
  }
}

class RecipeSearchScreen extends StatelessWidget {
  const RecipeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Recipe Search Screen'),
    );
  }
}

class ChefSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Chef Search Screen'),
    );
  }
}
