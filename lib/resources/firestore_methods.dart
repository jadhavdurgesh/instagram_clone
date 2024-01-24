import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:instagram_firebase/models/post.dart';
import 'package:uuid/uuid.dart';

import 'storage_methods.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String caption,
    String uid,
    Uint8List file,
    String username,
    String profileImage,
  ) async {
    String res = "Some error is occured";
    String postId = Uuid().v1();
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      Post post = Post(
          caption: caption,
          username: username,
          uid: uid,
          postUrl: photoUrl,
          postId: postId,
          profileImage: profileImage,
          datePublished: DateTime.now(),
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
