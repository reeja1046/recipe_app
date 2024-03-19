import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class RadioButtonsRow extends StatefulWidget {
  final Function(int, String) onDifficultyChanged;
  final String difficultyText;

  const RadioButtonsRow({
    Key? key,
    required this.onDifficultyChanged,
    required this.difficultyText,
  }) : super(key: key);

  @override
  _RadioButtonsRowState createState() => _RadioButtonsRowState();
}

class _RadioButtonsRowState extends State<RadioButtonsRow> {
  int selectedRadio = 0;
  final Map<int, String> radioText = {
    1: 'Easy',
    2: 'Normal',
    3: 'Professional',
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              'Normal',
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
              'Professional',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
