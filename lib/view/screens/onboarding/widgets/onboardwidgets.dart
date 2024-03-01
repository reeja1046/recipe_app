import 'package:flutter/material.dart';

class OnBoardWidget extends StatelessWidget {
  final String imagePath;
  final String title1;
  final String title2;
  final String description1;
  final String description2;

  const OnBoardWidget({
    Key? key,
    required this.imagePath,
    required this.title1,
    required this.title2,
    required this.description1,
    required this.description2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    var kHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: kHeight,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: kHeight * 0.5,
                    width: kWidth,
                    child: Image(
                      image: AssetImage(imagePath),
                    ),
                  ),
                  Text(
                    title1,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    title2,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description1,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Text(
                    description2,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
