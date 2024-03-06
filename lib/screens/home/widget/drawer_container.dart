import 'package:flutter/material.dart';

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
