import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


double getTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.width;
}

Widget buildTextField({required IconData icon, required String hintText}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
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
  const PasswordTextField({Key? key}) : super(key: key);

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
        style: const TextStyle(fontSize: 18),
      ),
    ),
  );
}

Widget buildRichTextWithNavigation() {
  return GestureDetector(
    onTap: () {
      // Navigate to the sign-in page here
    },
    child: RichText(
      text: const TextSpan(
        text: 'Already have an account? ',
        style: TextStyle(fontSize: 14, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign In',
            style: TextStyle(
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

Widget buildSocialLoginButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildSocialLoginButton(icon: FontAwesomeIcons.google, label: 'Google'),
      buildSocialLoginButton(
          icon: FontAwesomeIcons.facebook, label: 'Facebook'),
    ],
  );
}

Widget buildSocialLoginButton({required IconData icon, required String label}) {
  return SizedBox(
    width: 140,
    height: 30,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(
              icon,
              color: Colors.red,
              size: 15,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}
