
import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/screens/account/widgets/add_ingredients.dart';
import 'package:recipe_app/screens/account/widgets/add_instructions.dart';
import 'package:recipe_app/screens/account/widgets/custom_appbar.dart';
import 'package:recipe_app/screens/account/widgets/photo_upload_section.dart';
import 'package:recipe_app/screens/account/widgets/radio_button.dart';
import 'package:recipe_app/screens/account/widgets/time_and_calories.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name of Your Recipe',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 42,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the name',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const BuildTimeAndCalories(),
                    const SizedBox(height: 10),
                    const Text(
                      'Category',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 42,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Biriyani/Friedrice/Noodles',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Difficulty',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const RadioButtonsRow(),
                    const SizedBox(height: 10),
                    const Text(
                      'Ingredients',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      '(Enter each ingredients in each box) ',
                      style: TextStyle(fontSize: 12),
                    ),
                    const IngredientsForm(),
                    const Text(
                      'Instructions',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      '(Enter instructions by step by step) ',
                      style: TextStyle(fontSize: 12),
                    ),
                    const AddInstructions(),
                    const SizedBox(height: 10),
                    const PhotoUploadSection(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.baseColor),
                          onPressed: () {},
                          child: const Text(
                            'Create Cookbook',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
