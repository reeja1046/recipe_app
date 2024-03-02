import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/account/profile.dart';
import 'package:recipe_app/view/screens/cart/cart.dart';
import 'package:recipe_app/view/screens/home/home_screen.dart';
import 'package:recipe_app/view/screens/wishlist/wishlist.dart';
import 'package:super_bottom_navigation_bar/super_bottom_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const MyHomePage(),
    const MyWishList(),
    const MyCart(),
    const MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: SuperBottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        items: const [
          SuperBottomNavigationBarItem(
            unSelectedIcon: Icons.home_outlined,
            selectedIcon: Icons.home,
            splashColor: Colors.amber,
            borderBottomColor: Colors.amber,
            selectedIconColor: Colors.amber,
            unSelectedIconColor: Colors.black,
          ),
          SuperBottomNavigationBarItem(
            unSelectedIcon: Icons.favorite_border,
            selectedIcon: Icons.favorite,
            splashColor: Colors.amber,
            borderBottomColor: Colors.amber,
            selectedIconColor: Colors.amber,
            unSelectedIconColor: Colors.black,
          ),
          SuperBottomNavigationBarItem(
            unSelectedIcon: Icons.shopping_cart_outlined,
            selectedIcon: Icons.shopping_cart,
            splashColor: Colors.amber,
            borderBottomColor: Colors.amber,
            selectedIconColor: Colors.amber,
            unSelectedIconColor: Colors.black,
          ),
          SuperBottomNavigationBarItem(
            unSelectedIcon: Icons.person_outline_rounded,
            selectedIcon: Icons.person,
            splashColor: Colors.amber,
            borderBottomColor: Colors.amber,
            selectedIconColor: Colors.amber,
            unSelectedIconColor: Colors.black,
          ),
        ],
        onSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
