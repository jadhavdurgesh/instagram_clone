// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String caption;
  final String username;
  final String uid;
  final datePublished;
  final String postUrl;
  final String postId;
  final String profileImage;
  final likes;

  Post(
      {required this.caption,
      required this.username,
      required this.uid,
      required this.postUrl,
      required this.postId,
      required this.profileImage,
      required this.likes,
      required this.datePublished});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "caption": caption,
        "postUrl": postUrl,
        "postId": postId,
        "profileImage": profileImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        caption: snapshot['caption'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        postUrl: snapshot['psotUrl'],
        postId: snapshot['postId'],
        profileImage: snapshot['profileImage'],
        likes: snapshot['likes'],
        datePublished: snapshot['datepublished']);
  }
}
