import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:toast/toast.dart';

void showToast({required String message}) {
  Toast.show(
    message,
    duration: Toast.lengthLong,
    gravity: Toast.bottom,
    textStyle: const TextStyle(color: Colors.white, fontSize: 15),
    backgroundColor: AppColor.subBlackColor,
  );
}
