import 'package:flutter/material.dart';

class BuildTimeAndCalories extends StatefulWidget {
  final Function(String, String) onTimeAndCaloriesChanged;

  const BuildTimeAndCalories({Key? key, required this.onTimeAndCaloriesChanged})
      : super(key: key);

  @override
  State<BuildTimeAndCalories> createState() => _BuildTimeAndCaloriesState();
}class _BuildTimeAndCaloriesState extends State<BuildTimeAndCalories> {
  TextEditingController timeController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

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

  Widget _buildTimeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Est Time : ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          width: 100,
          child: TextField(
            controller: timeController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onTimeAndCaloriesChanged(value, caloriesController.text);
            },
            decoration: const InputDecoration(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calories : ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          width: 100,
          child: TextField(
            controller: caloriesController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onTimeAndCaloriesChanged(timeController.text, value);
            },
            decoration: const InputDecoration(
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
}
