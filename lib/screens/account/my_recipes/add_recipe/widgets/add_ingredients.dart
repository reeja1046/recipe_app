import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

class IngredientsForm extends StatefulWidget {
  final Function(List<String>) onIngredientsChanged;
  const IngredientsForm({Key? key, required this.onIngredientsChanged})
      : super(key: key);

  @override
  State<IngredientsForm> createState() => _IngredientsFormState();
}

class _IngredientsFormState extends State<IngredientsForm> {
  List<TextEditingController> ingredientControllers = [];
  double totalHeight = 320;
  final int maxIngredients = 4;
  final double textFieldHeight = 60;
  final double verticalPadding = 8.0;

  @override
  void initState() {
    super.initState();
    ingredientControllers =
        List.generate(maxIngredients, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in ingredientControllers) {
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < ingredientControllers.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    top: i == 0 ? 0 : verticalPadding,
                    bottom: i == ingredientControllers.length - 1
                        ? 0
                        : verticalPadding,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ingredientControllers[i],
                          decoration: InputDecoration(
                            labelText: 'Ingredient ${i + 1}',
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
                            widget.onIngredientsChanged(getIngredientsList());
                          },
                        ),
                      ),
                      if (i > maxIngredients - 1)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              ingredientControllers.removeAt(i);
                              totalHeight -= textFieldHeight + verticalPadding;
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                    ],
                  ),
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    ingredientControllers.add(TextEditingController());
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

  List<String> getIngredientsList() {
    return ingredientControllers.map((controller) => controller.text).toList();
  }
}
