import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

Widget exploreCard(context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColor.baseColor, borderRadius: BorderRadius.circular(20)),
    height: 150,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cook the best \nrecipes at home',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            width: 100,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Explore',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
