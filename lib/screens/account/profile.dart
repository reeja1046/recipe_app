import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: AppColor.baseColor),
              height: 250,
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ashishresume.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              height: 120,
              width: 120,
            ),
          ],
        ),
      ],
    ));
  }
}
