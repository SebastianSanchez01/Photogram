import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gram/screens/profile.dart';
import 'package:photo_gram/screens/search.dart';
import 'package:photo_gram/backend/user_provider.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<Widget> _children = [
    MainPage(),
    Search(),
    Profile(
      uid: FirebaseAuth.instance.currentUser!.uid,
    )
  ];

  @override
  void initState() {
    super.initState();
    addData().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PhotoGram'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: _children,
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
              backgroundColor: Colors.white,
            ),
          ]),
    );
  }
}
