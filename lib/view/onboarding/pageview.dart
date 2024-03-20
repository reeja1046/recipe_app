import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/view/onboarding/widgets/dots_indicator.dart';
import 'package:recipe_app/view/user_auth.dart/signup_screen.dart';
import 'package:recipe_app/view/onboarding/widgets/onboarding_one.dart';
import 'package:recipe_app/view/onboarding/widgets/onboarding_three.dart';
import 'package:recipe_app/view/onboarding/widgets/onboarding_two.dart';

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
                      Get.to(() => const SignUpScreen());
                    },
                    child: const Text(
                      'Skipp >>',
                      style: TextStyle(color: AppColor.subGreyColor),
                    ),
                  ),
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
                  Get.to(() => const SignUpScreen());
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
