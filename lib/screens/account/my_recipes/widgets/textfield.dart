import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final String title;
  final String hintText;

  const TextFieldForm({super.key, required this.title, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 43,
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
              // hintStyle: TextSize.hinttext,
              contentPadding: const EdgeInsets.all(5),
            ),
          ),
        ),
      ],
    );
  }
}
