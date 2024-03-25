import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:recipe_app/models/user_class.dart';

class MyUserController extends GetxController {
  final CollectionReference userProfileCollection =
      FirebaseFirestore.instance.collection('user_profile');
  final RxList<MyUsers> users = <MyUsers>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<List<MyUsers>> fetchUserDetails() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await userProfileCollection.get()
              as QuerySnapshot<Map<String, dynamic>>;

      final List<MyUsers> userList = querySnapshot.docs.map((doc) {
        final userData = doc.data();
        print(userData);
        return MyUsers(
            imageUrl: userData['UserProfileImage'] ?? 'assets/placeholder.jpg',
            userName: userData['UserName'] ?? '',
            userId: userData['UserId'] ?? '');
      }).toList();

      users.assignAll(userList);

      return userList;
    } catch (e) {
      print('Error fetching user details: $e');
      throw e;
    }
  }
}
