import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage__methods.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User>getUserDetails() async{
    firebase_auth.User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }
  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        //register
        firebase_auth.UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage(
          'profilePics',
          file,
          false,
        );
        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          username: username,
          photoUrl: photoUrl,
          bio: bio,
          followers: [],
          following: [],
        );
        //add user to our database
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
      }
    } on firebase_auth.FirebaseAuthException catch (err) {
      if (err.code == 'invalid-emial') {
        res = 'The emial is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 character';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging up user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on firebase_auth.FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'User not found';
      } else if (err.code == 'wrong-password') {
        res = 'Wrong password';
      } else {
        res = err.message ?? 'Some error Occured';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
