import 'package:flutter/material.dart';

class RadioButtonsRow extends StatefulWidget {
  const RadioButtonsRow({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonsRowState createState() => _RadioButtonsRowState();
}

class _RadioButtonsRowState extends State<RadioButtonsRow> {
  int selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio(
              value: 0,
              groupValue: selectedRadio,
              onChanged: (value) {
                setState(() {
                  selectedRadio = value as int;
                });
              },
            ),
            const Text('Easy'),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: selectedRadio,
              onChanged: (value) {
                setState(() {
                  selectedRadio = value as int;
                });
              },
            ),
            const Text('Normal'),
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
                });
              },
            ),
            const Text('Professional'),
          ],
        ),
      ],
    );
  }
}
