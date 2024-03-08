import 'package:flutter/material.dart';

class IngredientsForm extends StatefulWidget {
  const IngredientsForm({Key? key});

  @override
  _IngredientsFormState createState() => _IngredientsFormState();
}

class _IngredientsFormState extends State<IngredientsForm> {
  List<IngredientRow> ingredientRows = [IngredientRow()];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          for (var i = 0; i < ingredientRows.length; i++)
            Row(
              children: [
                Expanded(child: ingredientRows[i]),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      ingredientRows.removeAt(i);
                    });
                  },
                ),
              ],
            ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                ingredientRows.add(IngredientRow());
              });
            },
            child: const Text('Add More'),
          ),
        ],
      ),
    );
  }
}

class IngredientRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 42,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Biriyani/Friedrice/Noodles',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
