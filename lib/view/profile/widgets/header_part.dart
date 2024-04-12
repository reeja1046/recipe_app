import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/serivces/add_service.dart';

// ignore: must_be_immutable
class HeaderPart extends StatelessWidget {
  HeaderPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future:
          RecipeService().getUserData(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic>? userData = snapshot.data;
          if (userData != null) {
            return buildHeader(userData, context);
          } else {
            return SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: const Card(
                child: Center(
                  child: Text(
                    'User data not found \nComplete the profile',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget buildHeader(Map<String, dynamic> userData, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
          ),
        ),
        Positioned(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.baseColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(userData['UserProfileImage'] ?? ''),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                userData['UserName'] ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        // const Positioned(
        //   bottom: 10,
        //   left: 10,
        //   right: 10,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Column(
        //         children: [
        //           Text(
        //             '1345',
        //             style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 17,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           Text(
        //             'Followers',
        //             style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 15,
        //             ),
        //           ),
        //         ],
        //       ),
        //       Column(
        //         children: [
        //           Text(
        //             '567',
        //             style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 17,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           Text(
        //             'Following',
        //             style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 15,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
