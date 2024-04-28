import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_gram/backend/firestore_methods.dart';
import 'package:photo_gram/screens/comments.dart';
import 'package:provider/provider.dart';
import '../backend/user.dart';
import '../backend/user_provider.dart';

class PhotoPost extends StatefulWidget {
  final snap;
  const PhotoPost({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PhotoPost> createState() => _PhotoPostState();
}

class _PhotoPostState extends State<PhotoPost> {
  String? uid;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  deletePost(String postId) async {
    try {
      await FirestoreMethods().deletePost(postId);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'].toString() == uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Delete',
                                    ]
                                        .map(
                                          (e) => InkWell(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                              onTap: () {
                                                deletePost(
                                                  widget.snap['postId']
                                                      .toString(),
                                                );
                                                // remove the dialog box
                                                Navigator.of(context).pop();
                                              }),
                                        )
                                        .toList()),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  await FirestoreMethods().likePost(widget.snap['postId'],
                      userProvider.getUser.uid, widget.snap['likes']);
                },
                icon: (widget.snap['likes'].contains(uid))
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (Comments(
                            postId: widget.snap['postId'].toString()))));
                  },
                  icon: Icon(
                    Icons.comment_outlined,
                    color: Colors.white,
                  )),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${widget.snap['caption']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Click here to view Comments',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => (Comments(
                              postId: widget.snap['postId'].toString()))));
                    }),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
