import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/serivces/auth_services.dart';
import 'package:recipe_app/screens/user_auth.dart/signin_screen.dart';
import 'package:recipe_app/screens/user_auth.dart/widgets/phone_authentication.dart';

double getTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.width;
}

Widget buildTextField(
    {required IconData icon,
    required String hintText,
    required TextEditingController controller}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          controller: widget.controller,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock_outline),
            hintText: 'Password',
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildElevatedButton(String text, {required VoidCallback onPressed}) {
  return SizedBox(
    width: 200,
    height: 30,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  );
}

Widget buildRichTextWithNavigation(context,
    {required navigate, required text1, required clickbutton}) {
  return GestureDetector(
    onTap: () {
      print('/////////////////////////');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SignInScreen()));
    },
    child: RichText(
      text: TextSpan(
        text: text1,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: clickbutton,
            style: const TextStyle(
              color: Colors.red,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDividerWithText(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Expanded(
        child: Divider(
          color: Colors.black,
          thickness: 1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      const Expanded(
        child: Divider(
          color: Colors.black,
          thickness: 1,
        ),
      ),
    ],
  );
}

FirebaseAuthServies authService = FirebaseAuthServies();
Widget buildSocialLoginButtons(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildSocialLoginButton(
        icon: FontAwesomeIcons.google,
        label: 'Google',
        color: Colors.red,
        onPressed: () {
          authService.signInWithGoogle(context);
        },
      ),
      buildSocialLoginButton(
          onPressed: () {
            Get.to(() => const PhoneAuthentication());
          },
          icon: FontAwesomeIcons.phone,
          label: 'Number',
          color: Colors.red),
    ],
  );
}

Widget buildSocialLoginButton(
    {required IconData icon,
    required String label,
    required var color,
    required VoidCallback onPressed}) {
  return SizedBox(
    width: 140,
    height: 30,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: FaIcon(
        icon,
        color: color,
        size: 15,
      ),
      label: Text(
        label,
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
    ),
  );
}
