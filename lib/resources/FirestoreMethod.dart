import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passportpal/models/Posts.dart';
import 'package:passportpal/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload poast
  Future<String> uploadPost(String description, String uid, String username,
      Uint8List file, String profImages) async {
    String res = 'some error occured';
    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          PostUrl: photoUrl,
          profImages: profImages,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> PostComment(String postId, String text, String uid, String name,
      String profilepic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'text': text,
          'profilepic': profilepic,
          'name': name,
          'commentid': commentId,
          'datePublished': DateTime.now()
        });
      } else {
        print('text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();

      List following = (snap.data() as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> PostUniComment(String postId, String text, String uid,
      String name, String profilepic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('universities')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'text': text,
          'profilepic': profilepic,
          'name': name,
          'commentid': commentId,
          'datePublished': DateTime.now()
        });
      } else {
        print('text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeUniPost(String uniId, String uid, List<String> likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('universities').doc(uniId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('universities').doc(uniId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print("vhor");
      print(uniId);
      print(e.toString());
    }
  }
}
