import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';

Widget profilePic() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColor.baseColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(60),
    ),
    child: const Stack(children: [
      CircleAvatar(
        backgroundImage: AssetImage('assets/ashishresume.jpg'),
        radius: 60,
      ),
      Positioned(
          bottom: 5,
          right: 0,
          child: Icon(
            Icons.camera_alt,
            size: 30,
          ))
    ]),
  );
}

Widget textEnteringField({
  required text,
  required keyboardtype,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text),
      TextFormField(
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.edit),
        ),
        keyboardType: keyboardtype,
      ),
    ],
  );
}
