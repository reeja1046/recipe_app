// import 'package:flutter/material.dart';

// class CustomTimePicker extends StatefulWidget {
//   final void Function(TimeOfDay)? onTimeSelected;

//   const CustomTimePicker({Key? key, this.onTimeSelected}) : super(key: key);

//   @override
//   _CustomTimePickerState createState() => _CustomTimePickerState();
// }

// class _CustomTimePickerState extends State<CustomTimePicker> {
//   TimeOfDay _selectedTime = TimeOfDay.now();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Selected Time: ${_selectedTime.format(context)}',
//           style: TextStyle(fontSize: 16.0),
//         ),
//         ElevatedButton(
//           onPressed: () => _selectTime(context),
//           child: Text('Select Time'),
//         ),
//       ],
//     );
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? selectedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );
//     if (selectedTime != null && widget.onTimeSelected != null) {
//       setState(() {
//         _selectedTime = selectedTime;
//       });
//       widget.onTimeSelected!(selectedTime);
//     }
//   }
// }
