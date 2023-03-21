// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_element

import 'package:climate_care/Models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_post.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  bool liked = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool isLiked = false;

  TextStyle dateStyle() {
    return const TextStyle(color: Colors.grey, fontSize: 12);
  }

  Widget _buildList(QuerySnapshot<Object?>? snapshot) {
    if (snapshot!.docs.isEmpty) {
      return const Center(child: Text("No Plants in the garden Yet!"));
    } else {
      return ListView.builder(
        //reverse: true,
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final post = SocialPost.fromSnapshot(doc);
          return _buildListItem(post);
        },
      );
    }
  }

  Widget _buildListItem(SocialPost post) {
    void likeCheck() async {
      final result = await FirebaseFirestore.instance
          .collection("Likes")
          .doc(userId)
          .snapshots()
          .contains(post.postId);
      if (result == true) {
        setState(() {
          isLiked = true;
        });
      } else {
        isLiked = false;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 183, 222, 139),
                      child: Text(
                        post.userName.characters.first,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      post.userName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "${post.date.toDate().day}, ",
                    style: dateStyle(),
                  ),
                  Text(
                    "${DateFormat.MMMM().format(post.date.toDate())}, ",
                    style: dateStyle(),
                  ),
                  Text(
                    "${post.date.toDate().year}",
                    style: dateStyle(),
                  ),
                ],
              ),
              Text(post.postText),
              SizedBox(
                height: post.photo != "" ? 250 : 05,
                width: double.infinity,
                child:
                    post.photo != "" ? Image.network(post.photo) : Container(),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Center(
              //       child: Row(
              //         children: [
              //           IconButton(
              //               onPressed: () {
              //                 if (liked == true) {
              //                   setState(() {
              //                     likeCheck();
              //                     final int postLikes = post.like - 1;
              //                     FirebaseFirestore.instance
              //                         .collection("Social Posts")
              //                         .doc(post.postId)
              //                         .update({"likes": postLikes});
              //                     FirebaseFirestore.instance
              //                         .collection("Like")
              //                         .doc(userId)
              //                         .update(
              //                             {post.postId: FieldValue.delete()});
              //                     liked = false;
              //                   });
              //                 } else {
              //                   setState(() {
              //                     likeCheck();
              //                     final int postLikes = post.like + 1;
              //                     FirebaseFirestore.instance
              //                         .collection("Social Posts")
              //                         .doc(post.postId)
              //                         .update({"likes": postLikes});
              //                     FirebaseFirestore.instance
              //                         .collection("Like")
              //                         .doc(userId)
              //                         .set({post.postId: true});
              //                     liked = true;
              //                   });
              //                 }
              //               },
              //               icon: Icon(isLiked
              //                   ? Icons.favorite
              //                   : Icons.favorite_border)),
              //           Text(post.like.toString()),
              //         ],
              //       ),
              //     ),
              //     ElevatedButton(
              //         onPressed: () {
              //           //likeCheck();
              //         },
              //         child: Text("check"))
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Community",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddPost.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Add a Post",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Social Posts")
                  .snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) return const LinearProgressIndicator();
                print(snapshot.data);
                return SizedBox(
                    height:
                        MediaQuery.of(context).size.height / 1.211212121212121,
                    child: _buildList(snapshot.data));
              }))
        ],
      )),
    );
  }
}
