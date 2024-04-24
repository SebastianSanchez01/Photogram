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
}
