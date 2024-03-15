import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/constants/sizedbox.dart';
import 'package:recipe_app/app/constants/text_strings.dart';
import 'package:recipe_app/screens/categories/category.dart';
import 'package:recipe_app/screens/home/widget/card.dart';
import 'package:recipe_app/screens/categories/category_button.dart';
import 'package:recipe_app/screens/home/widget/drawer_container.dart';
import 'package:recipe_app/screens/home/widget/explore_card.dart';
import 'package:recipe_app/screens/search/search_screen.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final SizedBoxHeightWidth sizeBoxHelper = SizedBoxHeightWidth();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'What Are You \nCooking Today ?',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            _toggleDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    sizeBoxHelper.kheight10,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SearchScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.search,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizeBoxHelper.kheight20,
                    exploreCard(context),
                    sizeBoxHelper.kheight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Categories', style: TextSize.titletextsize),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const CategoryScreen());
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                                color: AppColor.baseColor, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: CategoryButtons(),
                    ),
                    sizeBoxHelper.kheight10,
                    const Text('Recipe of the Day',
                        style: TextSize.titletextsize),
                    sizeBoxHelper.kheight10,
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailedRecipeScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/chicken biriyani.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          right: 20,
                          top: 20,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.favorite_border_outlined,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Chicken Biriyani',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    sizeBoxHelper.kheight10,
                    const Text('Quick And Easy', style: TextSize.titletextsize),
                    sizeBoxHelper.kheight10,
                    Column(
                      children: [
                        QuickAndEasyCard(context),
                        sizeBoxHelper.kheight10,
                        QuickAndEasyCard(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Animated Drawer Container
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Transform.translate(
                  offset: Offset(0.0, _animation.value * 300),
                  child: child,
                ),
              );
            },
            child: MyDrawerContainer(),
          ),
        ],
      ),
    );
  }

  void _toggleDrawer() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
