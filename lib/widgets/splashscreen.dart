import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/images_strings.dart';
import 'package:recipe_app/screens/onboarding/pageview.dart';
import 'package:toast/toast.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ToastContext().init(context);
    var kwidth = MediaQuery.of(context).size.width * 0.25;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: MediaQuery.of(context).size.height * 0.5,
            left: animate ? kwidth : -80,
            child: const Text(
              'Culinary Craft',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
          ),
          //  circle 1 in the top-right corner
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? -25 : -60,
            right: animate ? -25 : -60,
            child: CircleAvatar(
              backgroundImage: AssetImage(tSplashScreenTopImage),
              radius: 90,
            ),
          ),
          // Circle 2 in the bottom-left corner
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: animate ? -25 : -60,
            left: animate ? -25 : -60,
            child: CircleAvatar(
              backgroundImage: AssetImage(tSplashScreenBottomImage),
              radius: 90,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => animate = true);
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const PageScreen()));
  }
}