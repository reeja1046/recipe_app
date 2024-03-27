import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

class CategoryDropdown extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<String> categories;

  const CategoryDropdown({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String defaultValue = categories.isNotEmpty ? categories.first : '';

    return SizedBox(
      height: 42,
      child: DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty ? controller.text : defaultValue,
        onChanged: (String? newValue) {
          controller.text = newValue ?? ''; // Update selected category
        },
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColor.baseColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColor.baseColor),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.only(left: 15),
        ),
      ),
    );
  }
}
