import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/models_export.dart' as model;
import 'package:instagram_clone/resources/resources_export.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetail() async {
    final userId = _auth.currentUser?.uid;
    final documentSnapshot =
        await _firestore.collection('users').doc(userId).get();
    final user = model.User.fromFirestore(documentSnapshot);
    return user;
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? imageData,
  }) async {
    String res = "Unkown error Occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          imageData != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        _firestore.collection('users').doc(cred.user?.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          // 'photoUrl': photoUrl,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        await Storage().uploadImage(
            childName: 'profilePics', isPost: false, imageData: imageData);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> logInUser(
      {required String email, required String password}) async {
    String res = 'Unkown error occured';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  void signoutUser() {
    _auth.signOut();
  }
}
