import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

class CategoryDropdown extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final List<String> categories;
  final Function(String) onNewCategoryAdded;

  const CategoryDropdown({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.categories,
    required this.onNewCategoryAdded,
  }) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.controller.text.isNotEmpty
        ? widget.controller.text
        : widget.categories.isNotEmpty
            ? widget.categories.first
            : 'Others';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        if (newValue == 'Others') {
          _showAddCategoryDialog(context);
        } else {
          widget.controller.text = newValue ?? '';
          setState(() {
            dropdownValue = newValue!;
          });
        }
      },
      items: [
        ...widget.categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        const DropdownMenuItem<String>(
          value: 'Others',
          child: Text('Others'),
        ),
      ],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: AppColor.baseColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: AppColor.baseColor),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColor.baseColor),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    String newCategoryName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: TextFormField(
            onChanged: (value) {
              newCategoryName = value;
            },
            decoration: const InputDecoration(
              labelText: 'Category Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                print(newCategoryName);
                if (newCategoryName.isNotEmpty) {
                  widget.onNewCategoryAdded(newCategoryName);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
