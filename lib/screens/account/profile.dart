import 'package:flutter/material.dart';
import 'package:recipe_app/app/constants/sizedbox.dart';
import 'package:recipe_app/screens/account/my_recipes/widgets/header_part.dart';
import 'package:recipe_app/screens/account/my_recipes/my_recipe_screen.dart';

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
                    'Account', Icons.person, const MyRecipeScreen(), context),
                sizeBoxHelper.kheight10,
                accountListTile(
                    'My Recipes', Icons.collections, const MyRecipeScreen(), context),
                sizeBoxHelper.kheight10,
                accountListTile('Units of Measurements', Icons.ad_units,
                    const MyRecipeScreen(), context),
                sizeBoxHelper.kheight10,
                accountListTile(
                    'My Cookbooks', Icons.bookmark, const MyRecipeScreen(), context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget accountListTile(text, icon, navigate, context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => navigate));
      },
      title: Text(
        text,
        style: const TextStyle(fontSize: 17),
      ),
      leading: Icon(icon),
      trailing: IconButton(
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onPressed: () {},
      ),
    ),
  );
}
