import 'package:flutter/material.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:const SafeArea(
          child: Center(
        child: SizedBox(
          height: 140,
          child: Card(
            child: Column(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 50,
                ),
                Text(
                  'Payment Successful',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
