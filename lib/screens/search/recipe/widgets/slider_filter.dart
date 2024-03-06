import 'package:flutter/material.dart';

class CustomTimeBar extends StatefulWidget {
  const CustomTimeBar({Key? key}) : super(key: key);

  @override
  _CustomTimeBarState createState() => _CustomTimeBarState();
}

class _CustomTimeBarState extends State<CustomTimeBar> {
  double _startTime = 0.0;

  @override
  Widget build(BuildContext context) {
    int hours = _startTime.floor();
    int minutes = ((_startTime - hours) * 60).round();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Start Time: ${_formatTime(hours, minutes)}'),
        Slider(
          value: _startTime,
          onChanged: (value) {
            setState(() {
              _startTime = value;
            });
          },
          min: 0.0,
          max: 24.0,
          divisions: 24, // Assuming each hour is a division
          label: _formatTime(hours, minutes),
        ),
      ],
    );
  }

  String _formatTime(int hours, int minutes) {
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes';
  }
}
