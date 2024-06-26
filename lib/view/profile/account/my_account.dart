// ignore_for_file: unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/show_toast.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/core/serivces/add_service.dart';
import 'package:recipe_app/view/profile/account/widgets/date_picker.dart';
import 'package:recipe_app/view/profile/account/widgets/payment_screen.dart';
import 'package:recipe_app/view/profile/account/widgets/profile_photo_upload.dart';
import 'package:recipe_app/view/profile/account/widgets/text_entering_field.dart';

class MyAccountEdit extends StatefulWidget {
  const MyAccountEdit({Key? key}) : super(key: key);

  @override
  State<MyAccountEdit> createState() => _MyAccountEditState();
}

class _MyAccountEditState extends State<MyAccountEdit> {
  Map<String, dynamic>? userData;
  final RecipeService recipeService = RecipeService();
  String imageUrl = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final CollectionReference userDetail =
      FirebaseFirestore.instance.collection('user_profile');
  String? selectedRole;
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    checkUserPremiumStatus();
  }

  Future<void> fetchUserData() async {
    print(userDetail.id);
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      if (userId == null) {
        showToast(message: 'User is not signed in');
        return;
      }
      print('8888888888888333333333334444444444');
      print(userId);
      // Fetch user data from Firestore
      userData = await recipeService.getUserData(userId);
      print(userData);
      if (userData != null) {
        setState(() {
          // Set the text field controllers with fetched user data
          nameController.text = userData?['UserName'] ?? '';
          roleController.text = userData?['UserRole'] ?? '';
          emailController.text = userData?['UserEmail'] ?? '';
          mobileNumberController.text = userData?['UserPhone'] ?? '';
          dobController.text = userData?['UserDob'] ?? '';
          imageUrl = userData?['UserProfileImage'] ?? '';

          selectedRole = userData?['UserRole'];
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> checkUserPremiumStatus() async {
    try {
      // Get the current user ID
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        // Query Firestore to find documents where userId matches the current user's ID
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('premium')
            .where('userId', isEqualTo: userId)
            .get();

        // If any documents are returned, the user is considered premium
        setState(() {
          isPremium = snapshot.docs.isNotEmpty;
        });
      }
    } catch (error) {
      print('Error checking premium status: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizedBoxHeightWidth sizedboxhelper = SizedBoxHeightWidth();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        title: const Text(
          'Account',
          style: TextSize.appBarTitle,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(isPremium
                          ? 'Premium Account'
                          : 'Want to make Premium Account?'),
                      actions: isPremium
                          ? [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'OK',
                                  style: TextSize.subtitletext,
                                ),
                              ),
                            ]
                          : [
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
              icon: Icon(
                isPremium ? Icons.star : Icons.diamond_outlined,
                color: AppColor.subBlackColor,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 650,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: ProfilePic(
                            currentImage: imageUrl,
                            onImageSelected: (url) {
                              setState(() {
                                imageUrl = url;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextEnteringField(
                              text: 'Name',
                              keyboardtype: TextInputType.text,
                              controller: nameController,
                            ),
                            sizedboxhelper.kheight20,
                            const Text(
                              'Role',
                              style: TextSize.subtitletext,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: AppColor.baseColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: AppColor.baseColor),
                                ),
                                hintText: 'Choose one',
                                hintStyle: const TextStyle(
                                    color: AppColor.subGreyColor),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              value: selectedRole,
                              items: <String>['Basic', 'Advanced', 'Expert']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                roleController.text = value ?? '';
                                setState(() {
                                  selectedRole = value!;
                                });
                              },
                            ),
                            sizedboxhelper.kheight20,
                            TextEnteringField(
                              text: 'Email',
                              keyboardtype: TextInputType.emailAddress,
                              controller: emailController,
                            ),
                            sizedboxhelper.kheight20,
                            TextEnteringField(
                              text: 'Mobile Number',
                              keyboardtype: TextInputType.number,
                              controller: mobileNumberController,
                            ),
                            sizedboxhelper.kheight20,
                            DateEnteringField(
                              text: 'Date of Birth',
                              controller: dobController,
                            ),
                            sizedboxhelper.kheight30,
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.baseColor,
                                ),
                                onPressed: () {
                                  saveUserData();
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    if (userId == null) {
      showToast(message: 'User is not signed in');
      return;
    }

    bool userIdExists = await recipeService.doesUserIdExist(userId);

    if (userIdExists) {
      // User ID already exists in the database, handle accordingly
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User Already Exists'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    Map<String, dynamic> userData = {
      'UserId': userId,
      'UserName': nameController.text,
      'UserRole': roleController.text,
      'UserEmail': emailController.text,
      'UserPhone': mobileNumberController.text,
      'UserDob': dobController.text,
      'UserProfileImage': imageUrl,
    };
    print(userData);

    String username = nameController.text;
    String userrole = roleController.text;
    String useremail = emailController.text;
    String userphone = mobileNumberController.text;
    String userdbo = dobController.toString();

    if (username.isEmpty ||
        userrole.isEmpty ||
        useremail.isEmpty ||
        userphone.isEmpty ||
        imageUrl.isEmpty ||
        userdbo.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('All fields are required'),
            content: const Text('Please fill in all the required fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    recipeService.saveUserDetailsToFirebase(userData, userId);
  }
}
