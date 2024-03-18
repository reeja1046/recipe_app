import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/text_strings.dart';

class DateEnteringField extends StatefulWidget {
  const DateEnteringField({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;

  @override
  State<DateEnteringField> createState() => _DateEnteringFieldState();
}

class _DateEnteringFieldState extends State<DateEnteringField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != widget.controller.text) {
      setState(() {
        String formattedDate = '${picked.day}/${picked.month}/${picked.year}';
        widget.controller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextSize.subtitletextsize,
        ),
        SizedBox(
          height: 35,
          child: TextFormField(
            controller: widget.controller,
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColor.baseColor),
              ),
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.only(left: 15),
            ),
          ),
        ),
      ],
    );
  }
}
