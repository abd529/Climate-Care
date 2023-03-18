import 'package:cloud_firestore/cloud_firestore.dart';

class SocialPost {
  final String userName;
  final Timestamp date;
  final String photo;
  final String postText;
  final int like;
  SocialPost({
    required this.userName,
    required this.date,
    required this.like,
    required this.postText,
    required this.photo,
  });
  factory SocialPost.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return SocialPost(
        userName: map["name"],
        date: map["date"],
        like: map["likes"],
        postText: map["postText"],
        photo: map["photoLink"]);
  }
}
