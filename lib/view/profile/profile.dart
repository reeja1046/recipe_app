import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/sizedbox.dart';
import 'package:recipe_app/view/profile/account/my_account.dart';
import 'package:recipe_app/view/profile/widgets/header_part.dart';
import 'package:recipe_app/view/profile/recipes/my_recipe_screen.dart';
import 'package:recipe_app/view/profile/widgets/account_listtile.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final SizedBoxHeightWidth sizeBoxHelper = SizedBoxHeightWidth();
    return Scaffold(
      body: Column(
        children: [
          const HeaderPart(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                accountListTile(
                    'Account', Icons.person, const MyAccountEdit(), context),
                sizeBoxHelper.kheight10,
                accountListTile('My Recipes', Icons.collections,
                     MyRecipeScreen(), context),
                sizeBoxHelper.kheight10,
                accountListTile('Units of Measurements', Icons.ad_units,
                     MyRecipeScreen(), context),
                sizeBoxHelper.kheight10,
                accountListTile('My Cookbooks', Icons.bookmark,
                     MyRecipeScreen(), context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
