import 'package:flutter/material.dart';
import 'package:recipe_app/view/onboarding/widgets/onboardwidgets.dart';

class OnBoardingScreenTwo extends StatelessWidget {
  const OnBoardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OnBoardWidget(
                  imagePath: 'assets/explore.webp',
                  title1: 'Explore a variety of recipes for ',
                  title2: ' every taste and skill level.',
                  description1: 'Let us guide you to cook healthy',
                  description2: 'meals like a pro chef.',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
