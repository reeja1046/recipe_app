import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

class DifficultyDropDown extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const DifficultyDropDown({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  _DifficultyDropDownState createState() => _DifficultyDropDownState();
}

class _DifficultyDropDownState extends State<DifficultyDropDown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.controller.text.isNotEmpty
        ? widget.controller.text
        : 'Easy'; // Set default value to 'Easy'
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        widget.controller.text = newValue ?? '';
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: const [
        DropdownMenuItem<String>(
          value: 'Easy',
          child: Text('Easy'),
        ),
        DropdownMenuItem<String>(
          value: 'Medium',
          child: Text('Medium'),
        ),
        DropdownMenuItem<String>(
          value: 'Hard',
          child: Text('Hard'),
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
}
