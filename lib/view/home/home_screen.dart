import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/core/constants/text_strings.dart';
import 'package:recipe_app/view/categories/category.dart';
import 'package:recipe_app/view/categories/category_button.dart';
import 'package:recipe_app/view/home/widget/card.dart';
import 'package:recipe_app/view/home/widget/drawer_container.dart';
import 'package:recipe_app/view/home/widget/explore_card.dart';
import 'package:recipe_app/view/search/search_screen.dart';
import 'package:recipe_app/widgets/detailed_recipe.dart';
import 'package:recipe_app/controllers/home_controller.dart';

class MyHomePage extends StatelessWidget {
  final HomeController hcontroller = Get.put(HomeController());
  final SizedBoxHeightWidth sizedboxhelper = SizedBoxHeightWidth();

  MyHomePage({super.key});

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
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            hcontroller.toggleDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    sizedboxhelper.kheight10,
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
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                    sizedboxhelper.kheight20,
                    exploreCard(context),
                    sizedboxhelper.kheight10,
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
                              color: AppColor.baseColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: CategoryButtons(),
                    ),
                    sizedboxhelper.kheight10,
                    const Text('Recipe of the Day',
                        style: TextSize.titletextsize),
                    sizedboxhelper.kheight10,
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const DetailedRecipeScreen());
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizedboxhelper.kheight10,
                    const Text('Quick And Easy', style: TextSize.titletextsize),
                    sizedboxhelper.kheight10,
                    Column(
                      children: [
                        QuickAndEasyCard(context),
                        sizedboxhelper.kheight10,
                        QuickAndEasyCard(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Animated Drawer Container
          Obx(() {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: 0,
              left: 0,
              right: 0,
              child: Transform.translate(
                offset: Offset(0.0, hcontroller.isDrawerOpen.value ? 0 : 350),
                child: const MyDrawerContainer(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
