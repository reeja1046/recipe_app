import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/premium.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/view/profile/account/widgets/payment_screen.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key});

  final PremiumController premiumController = Get.put(PremiumController());

  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    bool isPremiumUser = premiumController.premiumUserIds.contains(userId);

    return Stack(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColor.baseColor,
        ),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width,
        child: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              'Create New Recipe',
              style: TextSize.appBarTitle,
            ),
          ],
        )),
      ),
      const Positioned(
        top: -5,
        left: -35,
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/chicken biriyani.jpg'),
        ),
      ),
      if (!isPremiumUser)
        Positioned(
            bottom: 50,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.diamond_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          const Text('Want to make it \nPremium Recipe?'),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text(
                                            'If you make your recipe premium, you can earn from that particular recipe.But at first you need  to make your account premium.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Ok',
                                              style: TextSize.subtitletext,
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.info_outline))
                        ],
                      ),
                      actions: [
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
                            Get.to(() => const PaymentScreen());
                          },
                          child: const Text(
                            'Click here',
                            style: TextSize.subtitletext,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ))
    ]);
  }
}
    // showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   title: Text('Want to make Premium Account?'),
    //                   actions: [
    //                     TextButton(
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                       child: const Text(
    //                         'Cancel',
    //                         style: TextSize.subtitletext,
    //                       ),
    //                     ),
    //                     TextButton(
    //                       onPressed: () {
    //                         Get.to(() => const PaymentScreen());
    //                       },
    //                       child: const Text(
    //                         'Click here',
    //                         style: TextSize.subtitletext,
    //                       ),
    //                     ),
    //                   ],
    //                 );
    //               },
    //             );