import 'package:flutter/material.dart';

class PopularChefListTile extends StatelessWidget {
  const PopularChefListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          // Your builder function goes here
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/hanna.jpg'),
            ),
            title: const Text('Reeja Grace Sabu'),
            subtitle: const Text('2k followers'),
            trailing: OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Follow',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 10,
            ));
  }
}
