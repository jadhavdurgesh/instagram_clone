import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_firebase/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user function
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occcured";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //resgiter user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        // add user to database
        print(cred.user!.uid);
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'email': email,
          'uid': cred.user!.uid,
          'bio': bio,
          'following': [],
          'followers': [],
          'photoUrl': photoUrl
        });

        // If you don't want to use uid anywhere in the app then there is alternative which generate unique auto-id for each user's
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'email': email,
        //   'uid': cred.user!.uid,
        //   'bio': bio,
        //   'following': [],
        //   'followers': []
        // });
        res = "success";
      }
    }
    // This is another way to handle error if there are more error to show on screen .
    // } on FirebaseAuthException catch(err){
    //   if(err.code == 'invalid-email'){
    //     res = 'The email is badly formatted';
    //   } else if( err.code == 'weak-password'){
    //     res = 'Your password is weak';
    //   }

    catch (e) {
      res = e.toString();
    }
    return res;
  }

  // loggin in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = "Please enter your credentials";
      }
    } catch (e) {
      res = e.toString();
    } 
    return res;
    
  }
}
