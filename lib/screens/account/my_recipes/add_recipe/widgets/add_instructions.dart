import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class AddInstructions extends StatefulWidget {
  final Function(List<String>) onInstructionsAdded;
  const AddInstructions({Key? key, required this.onInstructionsAdded})
      : super(key: key);

  @override
  State<AddInstructions> createState() => _AddInstructionsState();
}

class _AddInstructionsState extends State<AddInstructions> {
  List<String> instructionsList = [];
  List<TextEditingController> instructionsControllers = [];
  double totalHeight = 320;
  final int maxInstructions = 4;
  final double textFieldHeight = 60;
  final double verticalPadding = 8.0;

  @override
  void initState() {
    super.initState();
    instructionsControllers =
        List.generate(maxInstructions, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in instructionsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: totalHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.baseColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < instructionsControllers.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    top: i == 0
                        ? 0
                        : verticalPadding, // No padding for the first row
                    bottom: i == instructionsControllers.length - 1
                        ? 0
                        : verticalPadding, // No padding for the last row
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: instructionsControllers[i],
                          decoration: InputDecoration(
                            labelText: 'Step ${i + 1}',
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
                          onChanged: (value) {
                            widget.onInstructionsAdded(getInstructionsList());
                          },
                        ),
                      ),
                      if (i > maxInstructions - 1)
                        IconButton(
                          onPressed: () {
                            {
                              setState(() {
                                instructionsControllers.removeAt(i);
                                totalHeight -=
                                    textFieldHeight + verticalPadding;
                              });
                            }
                          },
                          icon: const Icon(Icons.delete),
                        ),
                    ],
                  ),
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    instructionsControllers.add(TextEditingController());
                    totalHeight += textFieldHeight + verticalPadding;
                  });
                },
                child: const Text(
                  'Add More',
                  style: TextStyle(color: AppColor.baseColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> getInstructionsList() {
    return instructionsControllers
        .map((controller) => controller.text)
        .toList();
  }
}
