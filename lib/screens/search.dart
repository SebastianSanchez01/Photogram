import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_gram/backend/user.dart';
import 'package:photo_gram/backend/user_provider.dart';
import 'package:photo_gram/screens/profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Form(
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                      labelText: 'Search for a user...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  onFieldSubmitted: (String _) {
                    setState(() {
                      isShowUsers = true;
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 10),
            /*  ElevatedButton(
              onPressed: () {
                setState(() {
                  isShowUsers = true;
                });
              },
              child: Text(
                  'Search'), 
            ),
          */
          ],
        ),
        (isShowUsers)
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: searchController.text,
                    )
                    .where('username', isNotEqualTo: user.username)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Profile(
                                uid: (snapshot.data! as dynamic).docs[index]
                                    ['uid'],
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                (snapshot.data! as dynamic).docs[index]
                                    ['photoUrl'],
                              ),
                              radius: 16,
                            ),
                            title: Text(
                              (snapshot.data! as dynamic).docs[index]
                                  ['username'],
                            ),
                          ),
                        );
                      },
                    );
                  }
                })
            : Text("Help")
      ],
    );
  }
}
