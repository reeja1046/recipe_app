import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/colors.dart';
import 'package:recipe_app/core/constants/text_strings.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        centerTitle: true,
        title: const Text(
          'About Us',
          style: TextSize.appBarTitle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/logo.png')),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Flavor Fusion',
                  style: TextSize.subtitletext,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                  "Flavor Fusion is your ultimate culinary companion, offering a vast collection of recipes for every occasion. Our user-friendly platform brings together food enthusiasts from around the world to share, discover, and create delicious meals. Whether you're a novice cook or a seasoned chef, Culinary Craft is here to inspire and elevate your cooking experience. Join our community and embark on a flavorful journey today!"),
              const SizedBox(height: 8),
              const Text("App developed by : Reeja Grace Sabu."),
              const Spacer(),
              const Center(
                child: Column(
                  children: [
                    Text('1.0.0'),
                    Text('Copyright © 2023 Flavor Fusion'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

aboutUsPopUp(BuildContext context) {
  final widthDsp = MediaQuery.of(context).size.width;
  final heightDsp = MediaQuery.of(context).size.height;
  showAboutDialog(
      context: context,
      applicationIcon: Container(
        height: heightDsp * 0.09,
        width: widthDsp * 0.18,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      applicationName: "Flavor Fusion",
      applicationVersion: '1.0.0',
      applicationLegalese: 'Copyright © 2023 Flavor Fusion',
      children: [
        const Text(
            "Flavor Fusion is your ultimate culinary companion, offering a vast collection of recipes for every occasion. Our user-friendly platform brings together food enthusiasts from around the world to share, discover, and create delicious meals. Whether you're a novice cook or a seasoned chef, Culinary Craft is here to inspire and elevate your cooking experience. Join our community and embark on a flavorful journey today!"),
        SizedBox(
          height: heightDsp * 0.02,
        ),
        const Text("App developed by : \nReeja Grace Sabu.")
      ]);
}
