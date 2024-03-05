import 'package:flutter/material.dart';
import 'package:recipe_app/screens/login/sign_up/signup_screen.dart';
import 'package:recipe_app/screens/onboarding/widgets/onboardingone.dart';
import 'package:recipe_app/screens/onboarding/widgets/onboardingthree.dart';
import 'package:recipe_app/screens/onboarding/widgets/onboardingtwo.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: const [
                  OnBoardingScreenOne(),
                  OnBoardingScreenTwo(),
                  OnBoardingScreenThree(),
                ],
              ),
            ),
            DotsIndicator(
              numberOfDots: 3,
              currentPage: currentPage,
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: currentPage < 2,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Skipp >>',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),
                Visibility(
                  visible: currentPage < 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentPage < 2) {
                        // Move to the next page
                        _pageController.animateToPage(
                          currentPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: currentPage == 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            color: index == currentPage ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
