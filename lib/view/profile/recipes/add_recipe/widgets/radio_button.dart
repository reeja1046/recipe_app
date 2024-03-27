import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

class RadioButtonsRow extends StatefulWidget {
  final Function(int, String) onDifficultyChanged;
  final String difficultyText;

  const RadioButtonsRow({
    Key? key,
    required this.onDifficultyChanged,
    required this.difficultyText,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonsRowState createState() => _RadioButtonsRowState();
}

class _RadioButtonsRowState extends State<RadioButtonsRow> {
  int selectedRadio = 0;
  final Map<int, String> radioText = {
    1: 'Easy',
    2: 'Medium',
    3: 'Hard',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.baseColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value as int;
                    widget.onDifficultyChanged(
                      selectedRadio,
                      radioText[selectedRadio] ?? '',
                    );
                  });
                },
                activeColor: AppColor.baseColor,
              ),
              const Text(
                'Easy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value as int;
                    widget.onDifficultyChanged(
                      selectedRadio,
                      radioText[selectedRadio] ?? '',
                    );
                  });
                },
                activeColor: AppColor.baseColor,
              ),
              const Text(
                'Medium',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 3,
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value as int;
                    widget.onDifficultyChanged(
                      selectedRadio,
                      radioText[selectedRadio] ?? '',
                    );
                  });
                },
                activeColor: AppColor.baseColor,
              ),
              const Text(
                'Hard',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
