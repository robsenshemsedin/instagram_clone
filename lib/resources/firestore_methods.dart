import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/models/models_export.dart';
import 'package:instagram_clone/resources/resources_export.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethos {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    User user,
  ) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String postUrl = await StorageMethods()
          .uploadImage(childName: 'posts', imageData: file, isPost: true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: user.uid,
        username: user.username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        profImage: user.photoUrl,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";

    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> postComment(
    String postId,
    String comment,
    String uid,
    String userName,
    String profilePicUrl,
  ) async {
    final String commentId = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .set({
      'profilePic': profilePicUrl,
      'name': userName,
      'uid': uid,
      'text': comment,
      'commentId': commentId,
      'datePublished': DateTime.now(),
    });
  }

  Future<String> deletePost(String postId) async {
    String res = 'Some error occured';
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(followId)
          .get();
      final userData = (user.data() as dynamic);
      Map<String, String>;
      if (userData['followers']!.contains(uid)) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followId)
            .update({
          'followers': FieldValue.arrayRemove([uid])
        });
      } else {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followId)
            .update({
          'followers': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
