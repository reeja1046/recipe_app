class Recipes {
  String? recipeName;
  String? etsTime;
  String? calories;
  String? category;
  String? description;
  String? difficultyText;
  String? userId;
  List<String>? ingredients;
  String imageUrl;

  Recipes(
      {required this.imageUrl,
      required this.calories,
      required this.category,
      required this.description,
      required this.ingredients,
      required this.etsTime,
      required this.recipeName,
      required this.difficultyText,
      required List<String> instructions,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'etsTime': etsTime,
      'calories': calories,
      'category': category,
      'difficultyText': difficultyText,
      'description': description,
      'id' : userId,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
    };
  }
}




// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';

// class ProfileModel extends Equatable {
//   final String id;
//   final String userName;
//   final String userEmail;
//   final String userPhone;
//   final String userGender;
//   final String userDob;
//   final String userImageUrl;
//   const ProfileModel({
//     this.id = '',
//     required this.userName,
//     required this.userEmail,
//     this.userPhone = '',
//     this.userGender = '',
//     this.userDob = '',
//     this.userImageUrl = '',
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         userName,
//         userEmail,
//         userPhone,
//         userGender,
//         userDob,
//         userImageUrl,
//       ];

//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'userName': userName,
//         'userEmail': userEmail,
//         'userPhone': userPhone,
//         'userGender': userGender,
//         'userDob': userDob,
//         'userImageUrl': userImageUrl,
//       };

//   factory ProfileModel.fromSnapshot(DocumentSnapshot snap) {
//     return ProfileModel(
//       id: snap['id'],
//       userName: snap['userName'],
//       userEmail: snap['userEmail'],
//       userPhone: snap['userPhone'],
//       userGender: snap['userGender'],
//       userDob: snap['userDob'],
//       userImageUrl: snap['userImageUrl'],
//     );
//   }

//   String toJson() => json.encode(toMap());
// }
