import 'dart:io';
import 'dart:typed_data';

import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class SocialRepository implements PostSource {
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static final CollectionReference _users =
      firestore.collection(FirebaseCollectionNames.users);
  static final CollectionReference _postsCollection =
      firestore.collection(FirebaseCollectionNames.posts);

  final LikesManager likesManager;

  SocialRepository(this.likesManager);

  BehaviorSubject<LoadingStateEnum> homeScreenState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  final List<PostViewModel> posts = [];

  Future createPost(PostModel postModel) async {
    await _postsCollection.add(postModel.toJson());
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

  Future<List> getUserPostLikes(String userId) async {
    return likesManager.getUserPostLikes(userId);
  }

  @override
  PostViewModel? getCachedPost(String id) {
    for (var i in posts) {
      if (i.postModel.id == id) return i;
    }
    return null;
  }

  @override
  void setPostLiked(postId, value) async {
    likesManager.setPostLiked(postId, value, posts);
  }

  @override
  Future likePost(String postId, String userId) async {
    await likesManager.likePost(postId, userId, posts);
  }

  @override
  Future unlikePost(String postId, String userId) async {
    await likesManager.unlikePost(postId, userId, posts);
  }

  Future<UserModel> _getUserById(String userId) async {
    final res = await _users.doc(userId).get();
    return UserModel.fromJson(res.data() as Map<String, dynamic>);
  }

  Future<List<PostViewModel>> getPosts() async {
    final querySnapshot =
        await _postsCollection.orderBy('createdAtMs', descending: true).get();

    final posts = <PostViewModel>[];
    for (var doc in querySnapshot.docs) {
      final post =
          PostModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      final user = await _getUserById(post.creatorId);
      posts.add(PostViewModel(user, post));
    }

    return posts;
  }

  @override
  List<PostViewModel> mergeWithLikes(List likes) {
    likesManager.mergeWithLikes(likes, posts);
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
}
