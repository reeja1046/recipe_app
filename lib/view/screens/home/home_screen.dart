import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/home/quick_and_easy/card.dart';
import 'package:recipe_app/view/screens/home/widget/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                       
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cook the best \nrecipes at home',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Explore',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(color: Colors.amber),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('All'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: const Text('Biriyani')),
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: const Text('Pulao')),
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: const Text('Fried Rice')),
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: const Text('Noodles')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Recipe of the Day',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Quick And Easy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    QuickAndEasyCard(context),
                    const SizedBox(
                      height: 10,
                    ),
                    QuickAndEasyCard(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
