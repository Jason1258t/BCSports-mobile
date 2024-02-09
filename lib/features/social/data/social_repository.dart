import 'dart:io';
import 'dart:typed_data';

import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/comment_model.dart';
import 'package:bcsports_mobile/features/social/data/models/comment_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class SocialRepository implements PostSource {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static final _users = _firestore.collection(FirebaseCollectionNames.users);
  static final _comments =
      _firestore.collection(FirebaseCollectionNames.comments);
  static final _postsCollection =
      _firestore.collection(FirebaseCollectionNames.posts);

  static final _postsBucket = _storage.ref(FirebaseCollectionNames.postsBucket);

  @override
  final BehaviorSubject<LikeChangesData> likeChanges = BehaviorSubject();

  @override
  final LikesManager likesManager;

  SocialRepository(this.likesManager) {
    likesManager.addSource(this);
  }

  BehaviorSubject<LoadingStateEnum> homeScreenState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  final List<PostViewModel> posts = [];

  void refreshPosts() async {
    posts.clear();
    initial();
  }

  void initial() async {
    homeScreenState.add(LoadingStateEnum.loading);
    try {
      posts.addAll(await getPosts());
      homeScreenState.add(LoadingStateEnum.success);
    } catch (e) {
      homeScreenState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  Future<List> getUserPostLikes(String userId) =>
      likesManager.getUserPostLikes(userId);

  @override
  PostViewModel? getCachedPost(String id) =>
      likesManager.getCachedPost(id, posts);

  @override
  void setPostLiked(postId, value) =>
      likesManager.setPostLiked(postId, value, posts);

  @override
  Future likePost(String postId, String userId) =>
      likesManager.likePost(postId, userId, posts);

  @override
  Future unlikePost(String postId, String userId) =>
      likesManager.unlikePost(postId, userId, posts);

  @override
  List<PostViewModel> mergeWithLikes() => likesManager.mergeWithLikes(posts);

  Future<List<PostViewModel>> getPosts() async {
    final querySnapshot =
        await _postsCollection.orderBy('createdAtMs', descending: true).get();

    final posts = <PostViewModel>[];
    for (var doc in querySnapshot.docs) {
      final post = PostModel.fromJson(doc.data());
      final user = await _getUserById(post.creatorId);
      posts.add(PostViewModel(user, post));
    }

    return posts;
  }

  Future<UserModel> _getUserById(String userId) async {
    final res = await _users.doc(userId).get();
    return UserModel.fromJson(res.data() as Map<String, dynamic>);
  }

  Future createPost(PostModel postModel) async {
    final post = await _postsCollection.add(postModel.toJson());
    await _postsCollection
        .doc(post.id)
        .set({'id': post.id}, SetOptions(merge: true));
  }

  Future<String> uploadPostImage({String? filePath, Uint8List? bytes}) async {
    assert(filePath != null || bytes != null);
    final fileRef = _postsBucket.child('${const Uuid().v1()}.jpeg');
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

  Future<CommentViewModel> createComment(CommentModel commentModel) async {
    final doc = await _comments.add(commentModel.toJson());

    final post = await _postsCollection.doc(commentModel.postId).get();

    await _postsCollection.doc(post.id).set(
        {'commentsCount': post['commentsCount'] + 1}, SetOptions(merge: true));

    final comment = CommentModel.fromJson(commentModel.toJson(), doc.id);
    final user = await _getUserById(commentModel.creatorId);

    return CommentViewModel(comment, user);
  }

  Future<List<CommentViewModel>> getPostComments(String postId) async {
    final comments = <CommentViewModel>[];

    final res = await _comments.where('postId', isEqualTo: postId).get();

    for (var doc in res.docs) {
      final comment = CommentModel.fromJson(doc.data(), doc.id);
      final user = await _getUserById(comment.creatorId);
      comments.add(CommentViewModel(comment, user));
    }

    return comments;
  }
}
