import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/login_screen.dart/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    var kHeight = MediaQuery.of(context).size.height;
    var kHeight20 = const SizedBox(height: 20);
    var kHeigth10 = const SizedBox(height: 10);
    var kHeight30 = const SizedBox(height: 30);

    return Scaffold(
      body: ClipRect(
        child: Stack(
          children: [
            Container(
              height: kHeight,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Transform(
                transform: Matrix4.skewY(-0.5),
                child: Container(
                  width: 200,
                  height: kHeight * 0.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/chicken biriyani.jpg'))),
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: (kWidth -
                      getTextWidth(
                          'Culinary Craft', const TextStyle(fontSize: 30))) /
                  2,
              child: const Text(
                'Culinary Craft',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: Container(
                height: kHeight * 0.65,
                width: kWidth - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    kHeight30,
                    const Text(
                      'Create An Account',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          buildTextField(
                              hintText: 'Full name',
                              icon: Icons.person_2_outlined),
                          kHeight20,
                          buildTextField(
                              hintText: 'Email', icon: Icons.email_outlined),
                          kHeight20,
                          const PasswordTextField(),
                          kHeight30,
                          buildElevatedButton(
                            'Sign Up',
                            onPressed: () {},
                          ),
                          kHeigth10,
                          buildRichTextWithNavigation(),
                          kHeight30,
                          buildDividerWithText('Or Sign Up With'),
                          kHeight30,
                          buildSocialLoginButtons(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
