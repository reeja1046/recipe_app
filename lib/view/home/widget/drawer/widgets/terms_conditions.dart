import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.baseColor,
        title: const Text(
          'Terms And Conditions',
          style: TextSize.appBarTitle,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Welcome to our recipe adding app. By using this app, you agree to abide by the following terms and conditions:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            // 1111111
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'By accessing or using the app, you agree to comply with these terms and conditions. If you do not agree with any part of these terms, you may not use the app.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            // 22222222222
            Text(
              '2. User Registration',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'To contribute recipes, users must register and provide accurate information. Users are responsible for maintaining the security of their account and password.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            //33333333
            Text(
              '3. User Conduct',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Users must respect others and refrain from posting offensive, inappropriate, or misleading content. Plagiarism and infringement of intellectual property rights are strictly prohibited.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            //4444444

            Text(
              '4. Content Ownership and Usage',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Users retain ownership of the recipes they contribute, but grant the app a license to use, modify, and distribute the content. Users are responsible for ensuring they have the rights to share any content.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            //555555
            Text(
              '5. Privacy Policy',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Please review our privacy policy to understand how we collect, use, and protect your personal information. By using the app, you consent to the terms outlined in the privacy policy.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            //6666666
            Text(
              '6. Intellectual Property Rights',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'All trademarks, logos, and content on the app are the property of their respective owners. Users must obtain permission before using any copyrighted material.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            //777777
            Text(
              '7. Liability Disclaimer',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We do not guarantee the accuracy, reliability, or completeness of any content on the app. Users are solely responsible for their interactions and use the app at their own risk.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            //8888888
            Text(
              '8. Termination of Services',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We reserve the right to suspend or terminate user accounts or access to the app for violations of the terms and conditions or other reasons deemed necessary.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            //9999999
            Text(
              '9. Updates and Modifications',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We may update or modify these terms and conditions periodically without prior notice. Your continued use of the app constitutes acceptance of these changes.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            //10101010
            Text(
              '10. Governing Law',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'These terms and conditions are governed by and construed in accordance with the laws of Jurisdiction. Any disputes arising from these terms and conditions will be subject to the exclusive jurisdiction of the courts in our Jurisdiction.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            //11111111
            Text(
              '11. Contact Information',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'If you have any questions, concerns, or feedback about these terms and conditions or the app in general, please contact us at reejagrace123@gmail.com.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
