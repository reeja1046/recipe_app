import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/chef_search.dart';
import 'package:recipe_app/models/user_class.dart';
import 'package:recipe_app/view/search/chef/chef_profile.dart';
import 'package:recipe_app/view/search/chef/popular_chef_listtile.dart';

class ChefSearchScreen extends StatefulWidget {
  const ChefSearchScreen({super.key});

  @override
  State<ChefSearchScreen> createState() => _ChefSearchScreenState();
}

class _ChefSearchScreenState extends State<ChefSearchScreen> {
  late TextEditingController _searchController;
  late List<MyUsers> _searchResults;
  late List<MyUsers> _allChefs;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchResults = [];
    _allChefs = [];
    _loadChefs();
  }

  void _loadChefs() async {
    MyUserController userController = MyUserController();
    List<MyUsers> allChefs = await userController.fetchUserDetails();
    setState(() {
      _allChefs = allChefs;
    });
  }

  void _searchChef(String query) {
    List<MyUsers> searchResults = _allChefs.where((chef) {
      return chef.userName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _searchResults = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 35,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _searchChef,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Popular Search',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchController.text.isNotEmpty) {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          MyUsers user = _searchResults[index];
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
      return const PopularChefListTile();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
