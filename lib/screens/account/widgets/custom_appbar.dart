import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
      const Positioned(
        top: -5,
        left: -20,
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/chicken biriyani.jpg'),
        ),
      )
    ]);
  }
}
