import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class IngredientsScreen extends StatefulWidget {
  IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  // Sample list of ingredients
  final List<String> ingredients = [
    'Chicken',
    'Rice',
    'Oil',
    'Chilly Powder',
    'Chicken Masala',
  ];
  bool throwShotAway = false;
  SizedBoxHeightWidth sizeboxhelper = SizedBoxHeightWidth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/chicken biriyani.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        sizeboxhelper.kheight10,
        Text(
          'Chicken Biriyani : Ingredients',
          style: TextSize.subtitletextsize,
        ),
        SizedBox(
          height: 300, // Adjust the height as needed
          child: ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.circle,
                  size: 10,
                ),
                title: Text(ingredients[index]),
                trailing: Checkbox(
                  value: throwShotAway,
                  onChanged: (bool? newValue) {
                    setState(() {
                      throwShotAway = newValue!;
                    });
                  },
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Back')),
            ElevatedButton(
                onPressed: () {}, child: Text('Add to shopping list'))
          ],
        )
      ]),
    );
  }
}
