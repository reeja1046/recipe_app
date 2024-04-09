import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/widgets/user_payment.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('add recipes')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('my cart')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Make the Payment to Enjoy!!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => const UserPaymentScreen());
                        },
                        child: const Text(
                          'Pay Now',
                          style: TextSize.subtitletextsize,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'cancel',
                          style: TextSize.subtitletextsize,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final recipeData = docs[index].data() as Map<String, dynamic>;
                return SizedBox(
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                recipeData['imageUrl'] ?? '',
                                fit: BoxFit.cover,
                                height: 130,
                              ),
                            ),
                            Text(
                              recipeData['recipeName'] ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.grey.withOpacity(0.7),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.lock),
                                  SizedBox(width: 4),
                                  Text(
                                    'Buy to Unlock',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
