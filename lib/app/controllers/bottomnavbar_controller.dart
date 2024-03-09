import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/screens/account/profile.dart';
import 'package:recipe_app/screens/cart/cart.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'package:recipe_app/screens/wishlist/wishlist.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;
  var isRepeat = false.obs;
  var isShuffle = false.obs;

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

    final List<Widget> pages = [
    const MyHomePage(),
    const FavoriteScreen(),
    const MyCart(),
    const MyProfile(),
  ];
  
}
