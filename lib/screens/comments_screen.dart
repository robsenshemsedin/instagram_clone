import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/models_export.dart';
import 'package:instagram_clone/resources/resources_export.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils_export.dart';
import 'package:instagram_clone/widgets/widgets_export.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  const CommentsScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  CommentsScreenState createState() => CommentsScreenState();
}

class CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  void postComment(String uid, String name, String profilePic) async {
    try {
      await FirestoreMethos().postComment(
        widget.postId,
        commentEditingController.text,
        uid,
        name,
        profilePic,
      );

      if (context.mounted) showSnackBar(context, 'Success!');

      setState(() {
        commentEditingController.text = "";
      });
    } catch (err) {
      if (!context.mounted) return;
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  void dispose() {
    commentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
        ),
        centerTitle: false,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => CommentCard(
                  snapshot: snapshot.data!.docs[index].data(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: commentEditingController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  postComment(user.uid, user.username, user.photoUrl);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
