import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:passportpal/resources/storage_method.dart';
import 'package:passportpal/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // signupuser

  Future<String> signUpUser(
      {required String email,
      required String fullname,
      required String phoneno,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "some error occured";

    try {
      if (email.isNotEmpty ||
              fullname.isNotEmpty ||
              phoneno.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              password.isNotEmpty ||
              file != null
          // file != null
          ) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user);
        String photoURL = await StorageMethod()
            .uploadImageToStorage('profilepics', file, false);

        //add user to our datbase
        model.User user = model.User(
            fullname: fullname,
            phoneno: phoneno,
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoURL);
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        //another method
        // await _firestore.collection('users').add({
        //    'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': []
        // });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = "login or password incorrect";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
      } else if (err.code == 'wrong-password') {
      } else {
        res = err.toString();
      }
      // res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
