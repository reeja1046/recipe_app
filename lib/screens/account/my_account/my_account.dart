import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/sizedbox.dart';
import 'package:recipe_app/app/constants/text_strings.dart';
import 'package:recipe_app/screens/account/my_account/widgets.dart';

class MyAccountEdit extends StatelessWidget {
  const MyAccountEdit({super.key});

  @override
  Widget build(BuildContext context) {
    SizedBoxHeightWidth sizedboxhelper = SizedBoxHeightWidth();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextSize.appBarTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  profilePic(),
                  sizedboxhelper.kheight20,
                  textEnteringField(
                      text: 'Name', keyboardtype: TextInputType.number),
                  sizedboxhelper.kheight20,
                  textEnteringField(
                      text: 'Role', keyboardtype: TextInputType.number),
                  sizedboxhelper.kheight20,
                  textEnteringField(
                      text: 'Email', keyboardtype: TextInputType.number),
                  sizedboxhelper.kheight20,
                  textEnteringField(
                      text: 'Mobile Number',
                      keyboardtype: TextInputType.number),
                  sizedboxhelper.kheight20,
                  textEnteringField(
                      text: 'Date of Birth',
                      keyboardtype: TextInputType.number),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColor.baseColor),
              onPressed: () {},
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
