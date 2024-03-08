import 'package:flutter/material.dart';

class BuildTimeAndCalories extends StatefulWidget {
  const BuildTimeAndCalories({super.key});

  @override
  State<BuildTimeAndCalories> createState() => _BuildTimeAndCaloriesState();
}

class _BuildTimeAndCaloriesState extends State<BuildTimeAndCalories> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimeInput(),
        _buildCaloriesInput(),
      ],
    );
  }
}

Widget _buildTimeInput() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Est Time : ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 38,
        width: 100,
        child: TextField(
          // controller: timeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Time',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.all(5),
          ),
        ),
      ),
    ],
  );
}

Widget _buildCaloriesInput() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Calories : ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 38,
        width: 100,
        child: TextField(
          // controller: caloriesController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Calories',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.all(5),
          ),
        ),
      ),
    ],
  );
}
