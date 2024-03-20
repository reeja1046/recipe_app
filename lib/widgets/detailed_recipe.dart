import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/widgets/ingredients.dart';

class DetailedRecipeScreen extends StatefulWidget {
  const DetailedRecipeScreen({Key? key}) : super(key: key);

  @override
  State<DetailedRecipeScreen> createState() => _DetailedRecipeScreenState();
}

class _DetailedRecipeScreenState extends State<DetailedRecipeScreen> {
  final CollectionReference recipeDetail =
      FirebaseFirestore.instance.collection('add recipes');
  // final CollectionReference userDetail =
  //     FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    final SizedBoxHeightWidth sizeBoxHelper = SizedBoxHeightWidth();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder<QuerySnapshot>(
          stream: recipeDetail.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Recipe');
            }
            final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

            final Map<String, dynamic> recipeData =
                documents.first.data() as Map<String, dynamic>;
            final String recipeName = recipeData['Name'] ?? 'Recipe';
            return Text(recipeName);
          },
        ),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: recipeDetail.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              if (documents.isEmpty) {
                return const Center(
                  child: Text(
                    'No Data Available.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              }

              final Map<String, dynamic> recipeData =
                  documents.first.data() as Map<String, dynamic>;
              final List<String> ingredients =
                  List<String>.from(recipeData['Ingredients'] ?? []);
              final List<String> instructions =
                  List<String>.from(recipeData['Instructions'] ?? []);

              return Padding(
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
                            child: Image.network(
                              recipeData['Image'],
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
                                '${recipeData['est Time']}',
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Chef : Ashish Joy',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${recipeData['DifficultyText']}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    sizeBoxHelper.kheight10,
                    Text(
                      '${recipeData['Description']}',
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
                      style: TextSize.subtitletextsize,
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
        ),
      ),
    );
  }
}
