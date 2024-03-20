import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class TextEnteringField extends StatefulWidget {
  const TextEnteringField({
    Key? key,
    required this.text,
    required this.keyboardtype,
    required this.controller,
  }) : super(key: key);

  final String text;
  final TextInputType keyboardtype;
  final TextEditingController controller;

  @override
  State<TextEnteringField> createState() => _TextEnteringFieldState();
}

class _TextEnteringFieldState extends State<TextEnteringField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text, // Accessing the text parameter using widget.text
          style: TextSize.subtitletextsize,
        ),
        SizedBox(
          height: 35,
          child: TextFormField(
            controller: widget.controller,
            keyboardType:
                widget.keyboardtype, // Accessing the keyboardType parameter
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.edit),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.only(left: 15),
            ),
          ),
        ),
      ],
    );
  }
}
