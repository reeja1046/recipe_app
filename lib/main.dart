import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/my_recipes.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/widgets/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool isUserSignedIn = FirebaseAuth.instance.currentUser != null;

  runApp(MyApp(isUserSignedIn: isUserSignedIn));
}

class MyApp extends StatelessWidget {
  final bool isUserSignedIn;

  const MyApp({Key? key, required this.isUserSignedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isUserSignedIn) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(primarySwatch: AppColor.baseColor),
        initialBinding: BindingsBuilder(() {
          Get.put(MyRecipeController()); // Initialize your controller
        }),
      );
    } else {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(primarySwatch: AppColor.baseColor),
      );
    }
  }
}
