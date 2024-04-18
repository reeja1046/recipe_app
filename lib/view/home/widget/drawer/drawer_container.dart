import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/view/home/widget/drawer/widgets/about_us.dart';
import 'package:recipe_app/view/home/widget/drawer/widgets/privacy.dart';
import 'package:recipe_app/view/home/widget/drawer/widgets/terms_conditions.dart';
import 'package:recipe_app/view/user_auth.dart/signin_screen.dart';

class MyDrawerContainer extends StatelessWidget {
  const MyDrawerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ListTile(
            title: const Text(
              ' Privacy',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.lock,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {
              Get.to(() => const PrivacyScreen());
            },
          ),
          ListTile(
            title: const Text(
              'Terms And Conditions',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.bookmark,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {
              Get.to(() => const TermsAndConditions());
            },
          ),
          ListTile(
            title: const Text(
              'About Us',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.info_outline,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {
              Get.to(() => const AboutUs());
            },
          ),
          ListTile(
            title: const Text(
              'Share',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.share,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {},
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Do you want to logout?'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextSize.subtitletext,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Get.find<MyRecipeController>().recipes.clear();
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                            },
                            child: const Text(
                              'Logout',
                              style: TextSize.subtitletext,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  aboutUsPopUp(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.width;
    final heightDsp = MediaQuery.of(context).size.height;
    showAboutDialog(
        context: context,
        applicationIcon: Container(
          height: heightDsp * 0.09,
          width: widthDsp * 0.18,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        applicationName: "Flavor Fusion",
        applicationVersion: '1.0.0',
        applicationLegalese: 'Copyright © 2023 Flavor Fusion',
        children: [
          const Text(
              "Flavor Fusion is your ultimate culinary companion, offering a vast collection of recipes for every occasion. Our user-friendly platform brings together food enthusiasts from around the world to share, discover, and create delicious meals. Whether you're a novice cook or a seasoned chef, Culinary Craft is here to inspire and elevate your cooking experience. Join our community and embark on a flavorful journey today!"),
          SizedBox(
            height: heightDsp * 0.02,
          ),
          const Text("App developed by : \nReeja Grace Sabu.")
        ]);
  }
}
