import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_gram/backend/post.dart';
import 'package:photo_gram/backend/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String postID = const Uuid().v1();

  Future<String> uploadPost(String caption, Uint8List file, String uid,
      String username, String profImage) async {
    String result = "";
    try {
      String photoURL =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      Post post = Post(
          caption: caption,
          uid: uid,
          username: username,
          likes: [],
          postId: postID,
          datePublished: DateTime.now(),
          postUrl: photoURL,
          profImage: profImage);

      _firestore.collection('posts').doc(postID).set(post.toJson());
      result = 'success';
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String result = '';
    try {
      if (text.isNotEmpty) {
        String commentID = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentID)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentID,
          'datePublished': DateTime.now(),
        });
        result = 'success';
      }
      return result;
    } catch (e) {
      result = e.toString();
      return result;
    }
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
