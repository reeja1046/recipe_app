import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/home/quick_and_easy/card.dart';
import 'package:recipe_app/view/screens/search/widgets/search_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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

    // Ensure that the drawer is initially closed
    // _controller.reverse();
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
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                              onPressed: () {},
                              child: const Text('Fried Rice')),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Quick And Easy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

class MyDrawerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ListTile(
            title: const Text(
              'Notifications',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading:
                const Icon(Icons.notifications, color: Colors.black, size: 30),
            trailing: const Icon(
              Icons.toggle_on,
              size: 40,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              ' Privacy',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.lock,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Terms And Conditions',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.bookmark,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'About Us',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.info_outline,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Share',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.share,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 25,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
