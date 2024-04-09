import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/view/profile/account/widgets/payment_successful.dart';

class UserPaymentScreen extends StatefulWidget {
  const UserPaymentScreen({Key? key}) : super(key: key);

  @override
  State<UserPaymentScreen> createState() => _UserPaymentScreenState();
}

class _UserPaymentScreenState extends State<UserPaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _amountController;
  late Razorpay _razorPay;

  @override
  void initState() {
    _amountController = TextEditingController();
    super.initState();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorPay.clear();
  }

  void handlerPaymentSuccess() {
    print("Payment Success");
  }

  void handlerErrorFailure() {
    print("Payment Failed");
  }

  void handerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        centerTitle: true,
        title: const Text(
          'Make Payment',
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 350,
              child: Card(
                shadowColor: Colors.black,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            contentPadding: const EdgeInsets.only(left: 15),
                            hintText: 'Enter payment details',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter payment details';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();

                          var options = {
                            "key": "rzp_test_SpP9SzIkhQs1Gw",
                            "amount": num.parse(_amountController.text) * 100,
                            "name": "Startup Projects",
                            "description": "Payment for work",
                            "prefill": {
                              "contact": "9207446683",
                              "email": "reejagrace1046@gmail.com"
                            },
                            "external": {
                              "wallets": ["paytm"]
                            },
                          };
                          try {
                            _razorPay.open(options); // Open Razorpay payment
                            // Get the current user ID
                            String userId =
                                FirebaseAuth.instance.currentUser!.uid;
                            if (userId != null) {
                              // Save payment details to Firestore
                              _savePaymentToFirestore(
                                  userId, double.parse(_amountController.text));
                            } else {
                              print('Try after some time');
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.baseColor,
                        ),
                        child: const Text(
                          'Pay now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _savePaymentToFirestore(String userId, double amount) {
    FirebaseFirestore.instance.collection('premium').add({
      'userId': userId,
      'amount': amount,
      'timestamp': Timestamp.now(),
    }).then((value) {
      print('Payment details saved successfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>const PaymentSuccessfulScreen()));
    }).catchError((error) {
      print('Failed to save payment details: $error');
    });
  }
}
