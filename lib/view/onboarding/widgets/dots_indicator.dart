
import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';

class DotsIndicator extends StatelessWidget {
  final int numberOfDots;
  final int currentPage;

  DotsIndicator({
    required this.numberOfDots,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfDots,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? Colors.black : AppColor.subGreyColor,
          ),
        ),
      ),
    );
  }
}
