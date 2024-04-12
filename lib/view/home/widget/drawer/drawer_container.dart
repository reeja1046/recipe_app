import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/view/home/widget/drawer/privacy.dart';
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
          // ListTile(
          //   title: const Text(
          //     'Notifications',
          //     style: TextStyle(color: Colors.black, fontSize: 18),
          //   ),
          //   leading:
          //       const Icon(Icons.notifications, color: Colors.black, size: 30),
          //   trailing: const Icon(
          //     Icons.toggle_on,
          //     size: 40,
          //   ),
          //   onTap: () {},
          // ),
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
            onTap: () {},
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
            onTap: () {},
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
}
