import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/view/account/profile.dart';
import 'package:recipe_app/view/cart/cart.dart';
import 'package:recipe_app/view/home/home_screen.dart';
import 'package:recipe_app/view/wishlist/wishlist.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;
  var isRepeat = false.obs;
  var isShuffle = false.obs;

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

    final List<Widget> pages = [
    MyHomePage(),
    const FavoriteScreen(),
    const MyCart(),
    const MyProfile(),
  ];
  
}