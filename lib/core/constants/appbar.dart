import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const MyAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.baseColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        text,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
