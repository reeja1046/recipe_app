import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/onboarding_screen.dart/pageview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoBoardingScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text(
              'Culinary Craft',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
          ),
          //  circle 1 in the top-right corner
          Positioned(
            top: -20,
            right: -20,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/chicken biriyani.jpg'),
              radius: 90,
            ),
          ),
          // Circle 2 in the bottom-left corner
          Positioned(
            bottom: -30,
            left: -30,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/hakka Noodles.jpg'),
              radius: 90,
            ),
          ),
        ],
      ),
    );
  }

  Future gotoBoardingScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>const PageScreen(),
      ),
    );
  }
}
