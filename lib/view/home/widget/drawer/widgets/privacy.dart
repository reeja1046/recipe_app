import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.baseColor,
        title: const Text(
          'Privacy Policy',
          style: TextSize.appBarTitle,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Privacy Policy', style: TextSize.mainTitleText),
            SizedBox(height: 16.0),
            Text(
              'This privacy policy governs the manner in which our app collects, uses, maintains, and discloses information collected from users.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text('Information Collection and Use',
                style: TextSize.mainTitleText),
            SizedBox(height: 8.0),
            Text(
              'We may collect personal identification information from users in a variety of ways, including, but not limited to, when users visit our app, register on the app, and in connection with other activities, services, features, or resources we make available on our app.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
