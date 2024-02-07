import 'dart:io';
import 'dart:typed_data';

import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class SocialRepository {
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  BehaviorSubject<LoadingStateEnum> homeScreenState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  final List<PostViewModel> posts = [];

  Future createPost(PostModel postModel) async {
    final collection = _getFeedPostsDatabaseReference();
    await collection.add(postModel.toJson());
  }

  void reloadPosts() async {
    posts.clear();
    initial();
  }

  void initial() async {
    homeScreenState.add(LoadingStateEnum.loading);
    try {
      final newPosts = await getPosts();
      posts.addAll(newPosts);
      homeScreenState.add(LoadingStateEnum.success);
    } catch (e) {
      homeScreenState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  Future<UserModel> _getUserById(String userId) async {
    final res = await _getUsersDatabaseReference().doc(userId).get();
    return UserModel.fromJson(res.data() as Map<String, dynamic>);
  }

  Future<List<PostViewModel>> getPosts() async {
    final collection = _getFeedPostsDatabaseReference();
    final querySnapshot =
        await collection.orderBy('createdAtMs', descending: true).get();

    final posts = <PostViewModel>[];
    for (var doc in querySnapshot.docs) {
      final post =
          PostModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      final user = await _getUserById(post.creatorId);
      posts.add(PostViewModel(user, post));
    }

    return posts;
  }

  Future<String> uploadPostImage({String? filePath, Uint8List? bytes}) async {
    assert(filePath != null || bytes != null);
    final storageRef = _getPostsImagesStorageReference();
    final fileRef = storageRef.child('${const Uuid().v1()}.jpeg');
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

  Reference _getPostsImagesStorageReference() {
    final reference = storage.ref(FirebaseCollectionNames.postsBucket);
    return reference;
  }

  CollectionReference _getFeedPostsDatabaseReference() {
    final reference = firestore.collection(FirebaseCollectionNames.posts);
    return reference;
  }

  CollectionReference _getUsersDatabaseReference() {
    final reference = firestore.collection(FirebaseCollectionNames.users);
    return reference;
  }
}
