import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/view/cart/cart.dart';
import 'package:recipe_app/view/profile/profile.dart';
import 'package:recipe_app/view/home/home_screen.dart';
import 'package:recipe_app/view/wishlist/favorite.dart';

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
