import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_app/app/constants/show_toast.dart';
import 'package:recipe_app/screens/home/home_screen.dart';

class FirebaseAuthServies {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print('/////////////*****************/////////////////');
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email already in use');
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
      // print('Some Error Occured');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password');
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
      print('Some Error Occured');
    }
    return null;
  }

  _signInWithGoogle(context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await _auth.signInWithCredential(credential);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>const MyHomePage()));
      }
    } catch (e) {
      showToast(message: "Some error occured $e");
    }
  }
}
