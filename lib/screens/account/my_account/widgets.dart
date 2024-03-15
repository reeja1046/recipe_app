import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/sizedbox.dart';
import 'package:recipe_app/app/constants/text_strings.dart';

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
  SizedBoxHeightWidth sizedBoxHelper = SizedBoxHeightWidth();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextSize.subtitletextsize,
      ),
      sizedBoxHelper.kheight10,
      SizedBox(
        height: 42,
        child: TextFormField(
          keyboardType: keyboardtype,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.edit),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: AppColor.baseColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
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
