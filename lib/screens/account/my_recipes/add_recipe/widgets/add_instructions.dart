// import 'package:flutter/material.dart';

// class AddInstructions extends StatefulWidget {
//   const AddInstructions({Key? key});

//   @override
//   _AddInstructionsState createState() => _AddInstructionsState();
// }

// class _AddInstructionsState extends State<AddInstructions> {
//   List<IngredientRow> ingredientRows = [IngredientRow()];

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           for (var i = 0; i < ingredientRows.length; i++)
//             Row(
//               children: [
//                 Expanded(child: ingredientRows[i]),
//                 IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () {
//                     setState(() {
//                       ingredientRows.removeAt(i);
//                     });
//                   },
//                 ),
//               ],
//             ),
//           const SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 ingredientRows.add(IngredientRow());
//               });
//             },
//             child: const Text('Add More'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class IngredientRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 42,
//               child: TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(5),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class AddInstructions extends StatefulWidget {
  const AddInstructions({Key? key});

  @override
  State<AddInstructions> createState() => _AddInstructionsState();
}

class _AddInstructionsState extends State<AddInstructions> {
  List<InstructionsModel> instructionslist =
      List.generate(4, (index) => InstructionsModel());

  @override
  Widget build(BuildContext context) {
    double totalHeight = 230 + instructionslist.length * 50;

    return Container(
      height: totalHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.baseColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter instructions step by step',
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: instructionslist.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Step ${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(color: AppColor.baseColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(color: AppColor.baseColor),
                          ),
                          contentPadding: const EdgeInsets.only(left: 15),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              child: const Text(
                'Add more',
                style: TextStyle(color: AppColor.baseColor),
              ),
              onPressed: () {
                setState(() {
                  instructionslist.add(InstructionsModel());
                  totalHeight += 50;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InstructionsModel {
  String name = '';
  bool selected = false;
}
