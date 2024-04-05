import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/search_chef_list.dart';
import 'package:recipe_app/models/user_class.dart';
import 'package:recipe_app/view/search/chef/widgets/chef_profile.dart';

class PopularChefListTile extends StatelessWidget {
  const PopularChefListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyUserController userController = MyUserController();

    return FutureBuilder<List<MyUsers>>(
      future: userController.fetchUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<MyUsers> users = snapshot.data!;

          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              MyUsers user = users[index];

              return ListTile(
                onTap: () {
                  Get.to(() => ChefProfile(
                        user: user,
                      ));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.imageUrl!),
                ),
                title: Text(user.userName!),
                trailing: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(0, 30)),
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 10),
          );
        } else {
          return const Text('No users found');
        }
      },
    );
  }
}
