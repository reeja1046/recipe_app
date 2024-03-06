import 'package:flutter/material.dart';

class TopSearchCard extends StatelessWidget {
  final BuildContext context;

  // ignore: prefer_const_constructors_in_immutables
  TopSearchCard(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 120,
              width: MediaQuery.of(context).size.width * 0.44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/chicken biriyani.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'Chicken Biriyani',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 120,
              width: MediaQuery.of(context).size.width * 0.44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/egg noodles.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'Chicken Biriyani',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
