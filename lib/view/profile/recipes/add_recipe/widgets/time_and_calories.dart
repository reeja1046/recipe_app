import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class BuildTimeAndCalories extends StatefulWidget {
  final Function(String, String) onTimeAndCaloriesChanged;

  const BuildTimeAndCalories({Key? key, required this.onTimeAndCaloriesChanged})
      : super(key: key);

  @override
  State<BuildTimeAndCalories> createState() => _BuildTimeAndCaloriesState();
}

class _BuildTimeAndCaloriesState extends State<BuildTimeAndCalories> {
  SizedBoxHeightWidth sizedboxhelper = SizedBoxHeightWidth();
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
          style: TextSize.subtitletextsize,
        ),
        sizedboxhelper.kheight10,
        SizedBox(
          height: 38,
          width: 100,
          child: TextField(
            controller: timeController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onTimeAndCaloriesChanged(value, caloriesController.text);
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              hintText: 'Time',
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.all(10),
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
          style: TextSize.subtitletextsize,
        ),
        sizedboxhelper.kheight10,
        SizedBox(
          height: 38,
          width: 100,
          child: TextField(
            controller: caloriesController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onTimeAndCaloriesChanged(timeController.text, value);
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              hintText: 'Calories',
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ],
    );
  }
}
