import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/myrecipes_controller.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/widgets/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Get.find<MyRecipeController>().recipes.clear(); // Clear recipes data
      }
    });
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(primarySwatch: AppColor.baseColor),
      // initialBinding: BindingsBuilder(() {
      //   Get.put(MyRecipeController()); // Initialize your controller
      // }),
    );
  }
}
