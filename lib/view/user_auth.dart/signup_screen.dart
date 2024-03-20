import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/serivces/auth_services.dart';
import 'package:recipe_app/view/user_auth.dart/signin_screen.dart';
import 'package:recipe_app/view/user_auth.dart/widgets/userinput_validator.dart';
import 'package:recipe_app/view/user_auth.dart/widgets/widgets.dart';
import 'package:recipe_app/widgets/bottom_navbar.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _authServies = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final SizedBoxHeightWidth _sizedbox = SizedBoxHeightWidth();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    var kHeight = MediaQuery.of(context).size.height;

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
                  width: kWidth,
                  height: kHeight * 0.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/chicken biriyani.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: kHeight * 0.08,
              left: (kWidth -
                      getTextWidth(
                          'Culinary Craft', const TextStyle(fontSize: 30))) /
                  2,
              child: const Text(
                'Culinary Craft',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: kHeight * 0.2,
              left: kWidth * 0.05,
              right: kWidth * 0.05,
              child: Container(
                height: kHeight * 0.7,
                width: kWidth * 0.9,
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
                    _sizedbox.kheight50,
                    const Text(
                      'Create An Account',
                      style: TextStyle(fontSize: 24),
                    ),
                    Padding(
                      padding: EdgeInsets.all(kWidth * 0.05),
                      child: Column(
                        children: [
                          buildTextField(
                            controller: _usernameController,
                            hintText: 'Full name',
                            icon: Icons.person_2_outlined,
                          ),
                          _sizedbox.kheight20,
                          buildTextField(
                            hintText: 'Email',
                            icon: Icons.email_outlined,
                            controller: _emailController,
                          ),
                          _sizedbox.kheight20,
                          PasswordTextField(controller: _passwordController),
                          _sizedbox.kheight40,
                          buildElevatedButton(
                            'Sign Up',
                            onPressed: () {
                              _userSignUp();
                            },
                          ),
                          _sizedbox.kheight20,
                          buildRichTextWithNavigation(
                            context,
                            navigate: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            text1: 'Already have an account? ',
                            clickbutton: 'Sign In',
                          ),
                          _sizedbox.kheight50,
                          buildDividerWithText('Or Sign Up With'),
                          _sizedbox.kheight40,
                          buildSocialLoginButtons(context),
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

  void _userSignUp() async {
    String password = _passwordController.text;
    String email = _emailController.text;
    String username = _usernameController.text;
    ToastContext().init(context);
    print(password);
    print(email);
    print(username);

    String? usernameError = InputValidator.validateUsername(username);
    String? emailError = InputValidator.validateEmail(email);
    String? passwordError = InputValidator.validatePassword(password);

    if (usernameError != null || emailError != null || passwordError != null) {
      showToast(message: 'Invalid input. Please check the fields.');
      return;
    }

    User? user = await _authServies.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      showToast(message: 'User is successfully created');
      Get.to(() => BottomNavBar());
    } else {
      showToast(message: 'Some error occurred');
    }
  }
}
