import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passportpal/Screens/unauthorized.dart';

import '../widgets/postCard.dart';

class PostsWidget extends StatelessWidget {
  final String selectedCountry;
  final TextEditingController searchController;

  const PostsWidget({
    Key? key,
    required this.selectedCountry,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
                color: Colors.amber,
              ),
            );
          }

          if (userSnapshot.hasData && userSnapshot.data != null) {
            final User user = userSnapshot.data!;

            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: Colors.amber,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  final posts = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) => PostCard(
                      snap: posts[index].data(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('No data available');
                }
              },
            );
          } else {
            return const UnAuthorized();
          }
        },
      ),
    );
  }
}
