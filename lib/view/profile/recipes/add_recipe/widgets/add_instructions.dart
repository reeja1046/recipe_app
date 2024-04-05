import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class AddInstructions extends StatefulWidget {
  final Function(List<String>) onInstructionsAdded;
  final List<String> initialInstructions;
  const AddInstructions(
      {Key? key,
      required this.onInstructionsAdded,
      required this.initialInstructions})
      : super(key: key);

  @override
  State<AddInstructions> createState() => _AddInstructionsState();
}

class _AddInstructionsState extends State<AddInstructions> {
  List<String> instructionsList = [];
  List<TextEditingController> instructionsControllers = [];
  double totalHeight = 120;
  final int maxInstructions = 1;
  final double textFieldHeight = 60;
  final double verticalPadding = 8.0;

  @override
  void initState() {
    super.initState();
    if (widget.initialInstructions.isNotEmpty) {
      instructionsControllers = widget.initialInstructions.map((ingredient) {
        TextEditingController controller = TextEditingController();
        controller.text = ingredient;
        totalHeight += textFieldHeight + verticalPadding;
        return controller;
      }).toList();
    } else {
      instructionsControllers =
          List.generate(maxInstructions, (index) => TextEditingController());
    }
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Instructions',
                style: TextSize.subtitletextsize,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    instructionsControllers.add(TextEditingController());
                    totalHeight += textFieldHeight + verticalPadding + 20;
                  });
                },
                child: const Text(
                  'Add More',
                  style: TextStyle(color: AppColor.baseColor),
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.baseColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 5, right: 5, bottom: 10),
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
                            Flexible(
                              child: TextFormField(
                                maxLines: null,
                                controller: instructionsControllers[i],
                                decoration: InputDecoration(
                                  labelText: 'Step ${i + 1}',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        color: AppColor.baseColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        color: AppColor.baseColor),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(left: 15),
                                ),
                                onChanged: (value) {
                                  widget.onInstructionsAdded(
                                      getInstructionsList());
                                  // setState(() {
                                  //   totalHeight = calculateTotalHeight();
                                  // });
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotalHeight() {
    double height = 120; // Initial height
    for (TextEditingController controller in instructionsControllers) {
      // Create a TextPainter to calculate the text height
      TextSpan span = TextSpan(text: controller.text);
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        maxLines: null,
      );
      tp.layout(maxWidth: MediaQuery.of(context).size.width - 60);
      height += tp.height + verticalPadding + 20;
    }
    return height;
  }

  List<String> getInstructionsList() {
    return instructionsControllers
        .map((controller) => controller.text)
        .toList();
  }
}
