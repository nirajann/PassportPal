import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passportpal/provider/user_provider.dart';
import 'package:passportpal/resources/FirestoreMethod.dart';
import 'package:passportpal/widgets/commentCard.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Comment"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index].data(),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(), color: Colors.white),
            child: Row(children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Comment as ${user.username}',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().PostComment(
                    widget.snap['postId'],
                    _commentController.text,
                    user.uid,
                    user.username,
                    user.photoUrl,
                  );

                  setState(() {
                    _commentController.text = '';
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'post',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
