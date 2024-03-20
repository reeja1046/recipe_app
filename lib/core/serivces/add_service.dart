import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveRecipeToFirebase(
      Map<String, dynamic> recipeData, userId) async {
    try {
      print(userId);
      // Save the recipe data to Firestore
      await firestore
          .collection('add recipes')
          .doc(userId)
          .collection('recipes')
          .add(recipeData)
          .then((value) => {print("Recipe added")});
      print('Recipe saved to Firebase');
    } catch (e) {
      print('Error saving recipe: $e');
    }
  }

  Future<void> saveUserDetailsToFirebase(
      Map<String, dynamic> userData, userId) async {
    try {
      await firestore.collection('user_profile').doc(userId).set(userData);
      //.then((value) => {print("User added  with ID : ${value.id}")});
      print('User Data saved to firebase');
    } catch (e) {
      print('Error Occured');
    }
  }

  Future<bool> doesUserIdExist(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user_profile')
          .where('UserId', isEqualTo: userId)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print('Error checking if user ID exists: $error');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('user_profile').doc(userId).get();
      print(userId);
      print(userSnapshot.data());
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        print('User data retrieved successfully: $userData');
        return userData;
      } else {
        print('Document does not exist for userId: $userId');
        return null;
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }
}
