import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_gram/backend/chat_page.dart';

class MessageBoard extends StatefulWidget {
  const MessageBoard({super.key});

  @override
  State<MessageBoard> createState() => _MessageBoardState();
}

class _MessageBoardState extends State<MessageBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (FirebaseAuth.instance.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['username']),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(
                    receiverUserEmail: data['email'],
                    receiverUserId: data['uid'],
                  )));
        },
      );
    } else {
      return Container();
    }
  }
}
