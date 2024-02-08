import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/onboarding/widgets/onboardwidgets.dart';

class OnBoardingScreenOne extends StatelessWidget {
  const OnBoardingScreenOne({super.key});

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
                  imagePath: 'assets/welcome.jpg',
                  title1: 'Welcome to Culinary Craft where',
                  title2: 'every meal is a joyous journey.',
                  description1: 'Explore healthy recipes crafted by',
                  description2: 'people for your vibrant life.',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
