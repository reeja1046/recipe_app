import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/my_recipes.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/serivces/auth_services.dart';
import 'package:recipe_app/view/user_auth.dart/signup_screen.dart';
import 'package:recipe_app/view/user_auth.dart/widgets/forgot_password.dart';
import 'package:recipe_app/view/user_auth.dart/widgets/widgets.dart';
import 'package:recipe_app/widgets/bottom_navbar.dart';
import 'package:toast/toast.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuthService _authServies = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final SizedBoxHeightWidth _sizedbox = SizedBoxHeightWidth();
  final MyRecipeController myRecipeController =
      Get.put(MyRecipeController()); // Instantiate MyRecipeController

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
                height: kHeight * 0.65,
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
                    _sizedbox.kheight30,
                    const Text(
                      'Welcome Back !!!!',
                      style: TextStyle(fontSize: 24),
                    ),
                    Padding(
                      padding: EdgeInsets.all(kWidth * 0.05),
                      child: Column(
                        children: [
                          buildTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            icon: Icons.email_outlined,
                          ),
                          _sizedbox.kheight20,
                          PasswordTextField(
                            controller: _passwordController,
                          ),
                          _sizedbox.kheight20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ForgotPassWord());
                                  print('clicked forgot  password');
                                },
                                child: const Text(
                                  'Forgot password?',
                                  style:
                                      TextStyle(color: AppColor.favButtonColor),
                                ),
                              ),
                            ],
                          ),
                          _sizedbox.kheight20,
                          buildElevatedButton(
                            'Sign In',
                            onPressed: () {
                              _userSignIn();
                            },
                          ),
                          _sizedbox.kheight10,
                          buildRichTextWithNavigation(context,
                              clickbutton: 'Sign Up', navigate: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            );
                          }, text1: "Don't have an account?  "),
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

  void _userSignIn() async {
    String password = _passwordController.text;
    String email = _emailController.text;
    ToastContext().init(context);
    User? user = await _authServies.signInWithEmailAndPassword(email, password);
    if (user != null) {
      showToast(message: 'User is successfully logged in');
      myRecipeController.fetchRecipes();
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()));
    } else {
      showToast(message: 'Some error occurred');
    }
  }
}
