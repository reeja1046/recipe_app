// import 'package:flutter/material.dart';
// import 'package:recipe_app/core/constants/colors.dart';

// class RadioButtonsRow extends StatefulWidget {
//   final Function(int, String) onDifficultyChanged;
//   final String difficultyText;
//   final TextEditingController controller;

//   const RadioButtonsRow(
//       {Key? key,
//       required this.onDifficultyChanged,
//       required this.difficultyText,
//       required this.controller})
//       : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _RadioButtonsRowState createState() => _RadioButtonsRowState();
// }

// class _RadioButtonsRowState extends State<RadioButtonsRow> {
//   int selectedRadio = 0;
//   final Map<int, String> radioText = {
//     1: 'Easy',
//     2: 'Medium',
//     3: 'Hard',
//   };


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColor.baseColor),
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           for (int index = 1; index <= 3; index++)
//             Row(
//               children: [
//                 Radio(
//                   value: index,
//                   groupValue: selectedRadio,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedRadio = value as int;
//                       widget.controller.text = selectedRadio.toString();
//                       widget.onDifficultyChanged(
//                         selectedRadio,
//                         radioText[selectedRadio] ?? '',
//                       );
//                     });
//                   },
//                   activeColor: AppColor.baseColor,
//                 ),
//                 Text(
//                   radioText[index]!,
//                   style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
