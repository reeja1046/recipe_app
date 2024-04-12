import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/models/user_class.dart';

class ChefHeaderPart extends StatelessWidget {
  final MyUsers user; // Define MyUsers object as a parameter

  const ChefHeaderPart({Key? key, required this.user})
      : super(key: key); // Update constructor

  @override
  Widget build(BuildContext context) {
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
          top: 50,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
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
                      NetworkImage(user.imageUrl!), // Use user.imageUrl
                  radius: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                user.userName!, // Use user.userName
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
        //               color: Colors.black,
        //               fontSize: 17,
        //               fontWeight: FontWeight.w500,
        //             ),
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
        //               color: Colors.black,
        //               fontSize: 17,
        //               fontWeight: FontWeight.w500,
        //             ),
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
