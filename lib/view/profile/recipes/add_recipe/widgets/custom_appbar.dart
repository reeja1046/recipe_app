import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColor.baseColor,
        ),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width,
        child: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              'Create New Recipe',
              style: TextSize.appBarTitle,
            ),
          ],
        )),
      ),
      const Positioned(
        top: -5,
        left: -35,
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/chicken biriyani.jpg'),
        ),
      )
    ]);
  }
}
