import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/core/constants/colors.dart'; // Import Firestore

class CategoryButtons extends StatefulWidget {
  const CategoryButtons({Key? key}) : super(key: key);

  @override
  _CategoryButtonsState createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  String? selectedCategory;
  late Future<List<String>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = fetchCategories();
  }

  Future<List<String>> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      List<String> categories =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      if (selectedCategory == null && categories.isNotEmpty) {
        selectedCategory = categories.first;
      }

      return categories;
    } catch (error) {
      throw Exception('Failed to fetch categories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String> categories = snapshot.data ?? [];
          return Row(
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: CategoryButton(
                  text: category,
                  onPressed: () => selectCategory(category),
                  isSelected: selectedCategory == category,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const CategoryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side:
              BorderSide(color: isSelected ? Colors.white : AppColor.baseColor),
          backgroundColor: isSelected ? AppColor.baseColor : Colors.transparent,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
