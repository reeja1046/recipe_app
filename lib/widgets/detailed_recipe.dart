import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/sizedbox.dart';
import 'package:recipe_app/app/constants/text_strings.dart';
import 'package:recipe_app/widgets/ingredients.dart';

class DetailedRecipeScreen extends StatelessWidget {
  DetailedRecipeScreen({super.key});
  // Sample list of ingredients
  final List<String> ingredients = [
    'Chicken',
    'Rice',
    'Oil',
    'Chilly Powder',
    'Chicken Masala',
  ];

  final List<String> instructions = [
    'Chicken',
    'Rice',
    'Oil',
    'Chilly Powder',
    'Chicken Masala',
  ];
  @override
  Widget build(BuildContext context) {
    final SizedBoxHeightWidth sizeBoxHelper = SizedBoxHeightWidth();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipe of the Day'),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                        child: Image.asset(
                          'assets/chicken biriyani.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 20,
                      top: 20,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          size: 24,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          Icon(
                            Icons.timelapse,
                            color: Colors.white,
                          ),
                          Text(
                            '120 min',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chicken Biriyani',
                      style: TextSize.subtitletextsize,
                    ),
                    Text(
                      'Medium',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Text(
                  'Chef : Ashish Joy',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                sizeBoxHelper.kheight10,
                const Text(
                  'Spicy beef steak is a delectable dish featuring tender cuts of beef seasoned with a robust blend of spices, including chili powder, cayenne, and garlic. Marinated to perfection, the steak is then seared or grilled to create a flavorful crust, resulting in a mouthwatering combination of heat and tenderness. Whether enjoyed as a standalone dish or paired with complementary sides, spicy beef steak is a savory and satisfying culinary experience.',
                ),
                sizeBoxHelper.kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ingredients :',
                      style: TextSize.subtitletextsize,
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
                      );
                    },
                  ),
                ),
                sizeBoxHelper.kheight10,
                const Text(
                  'Instructions',
                  style: TextSize.subtitletextsize,
                ),
                sizeBoxHelper.kheight10,
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
