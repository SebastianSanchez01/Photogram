import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:photo_gram/backend/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> getUserName(String userId) async {
    try {
      // Access Firestore and fetch the username
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return snapshot['username'];
      } else {
        return 'User not found';
      }
    } catch (error) {
      return 'Error';
    }
  }

  Future<void> sendMessage(String message, String receiverId) async {
    final String senderUserId = _firebaseAuth.currentUser!.uid.toString();
    final senderUserNameHelper = getUserName(senderUserId);
    final String senderUserName = await senderUserNameHelper;
    DateTime now = DateTime.now();
    final String timeStamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    Message newMessage = Message(
        message: message,
        senderName: senderUserName,
        timeStamp: timeStamp,
        senderId: senderUserId,
        receiverId: receiverId);

    List<String> ids = [senderUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
