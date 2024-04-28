import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_gram/backend/storage_methods.dart';
import 'package:photo_gram/backend/user.dart' as model;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _fireStore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email,
      String password, String username, String bio, Uint8List file) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePictures', file, false);
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'username': username,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': [],
        'following': [],
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
