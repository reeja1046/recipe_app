import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class CategoryButtons extends StatefulWidget {
  @override
  _CategoryButtonsState createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  String selectedCategory = 'Biriyani';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CategoryButton(
          text: 'Biriyani',
          onPressed: () => selectCategory('Biriyani'),
          isSelected: selectedCategory == 'Biriyani',
        ),
        const SizedBox(width: 10),
        CategoryButton(
          text: 'Pulao',
          onPressed: () => selectCategory('Pulao'),
          isSelected: selectedCategory == 'Pulao',
        ),
        const SizedBox(width: 10),
        CategoryButton(
          text: 'Fried Rice',
          onPressed: () => selectCategory('Fried Rice'),
          isSelected: selectedCategory == 'Fried Rice',
        ),
        const SizedBox(width: 10),
        CategoryButton(
          text: 'Noodles',
          onPressed: () => selectCategory('Noodles'),
          isSelected: selectedCategory == 'Noodles',
        ),
      ],
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

  CategoryButton({
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isSelected ? Colors.white : AppColor.baseColor),
        backgroundColor: isSelected ? AppColor.baseColor : null,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
