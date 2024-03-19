import 'package:flutter/material.dart';
import 'package:recipe_app/view/onboarding/widgets/onboardwidgets.dart';

class OnBoardingScreenThree extends StatelessWidget {
  const OnBoardingScreenThree({super.key});

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
                  imagePath: 'assets/start.jpg',
                  title1: 'Tap, Cook, Enjoy – Your culinary',
                  title2: 'adventure starts now!',
                  description1: "Together, let's dive into the vibrant world",
                  description2: 'of cooking with energy.',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
