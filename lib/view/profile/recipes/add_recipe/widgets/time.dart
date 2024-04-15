import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

class TimeField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const TimeField({
    Key? key,
    required this.hintText,
    required this.controller, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: 150,
      child: TextFormField(
        controller: controller,
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
