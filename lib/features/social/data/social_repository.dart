import 'dart:io';

import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialRepository {
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Reference _getPostsImagesStorageReference() {
    final reference = storage.ref('/feed_post_images');
    return reference;
  }

  CollectionReference _getFeedPostsDatabaseReference() {
    final reference = firestore.collection('posts');
    return reference;
  }

  Future createPost(PostModel postModel) async {
    final collection = _getFeedPostsDatabaseReference();
    await collection.add(postModel.toJson());
  }

  Future<List<PostModel>> getPosts() async {
    final collection = _getFeedPostsDatabaseReference();
    final querySnapshot = await collection.get();

    final posts = <PostModel>[];
    for (var doc in querySnapshot.docs) {
      posts.add(PostModel.fromJson(doc as Map<String, dynamic>));
    }

    return posts;
  }

  Future<String> uploadPostImage(String filePath) async {
    File file = File(filePath);
    final storageRef = _getPostsImagesStorageReference();
    try {
      final task = await  storageRef.putFile(file);
      return task.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
