import 'dart:io';
import 'dart:typed_data';

import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class SocialRepository {
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Reference _getPostsImagesStorageReference() {
    final reference = storage.ref(FirebaseCollectionNames.postsBucket);
    return reference;
  }

  CollectionReference _getFeedPostsDatabaseReference() {
    final reference = firestore.collection(FirebaseCollectionNames.posts);
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

  Future<String> uploadPostImage({String? filePath, Uint8List? bytes}) async {
    assert(filePath != null || bytes != null);
    final storageRef = _getPostsImagesStorageReference();
    final fileRef = storageRef.child(const Uuid().v1());
    final TaskSnapshot task;
    try {
      if (filePath != null) {
        File file = File(filePath);
        task = await fileRef.putFile(file);
      } else {
        task = await fileRef.putData(bytes!);
      }
      return task.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
