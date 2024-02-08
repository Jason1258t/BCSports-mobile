import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class FavouritePostsRepository implements PostSource {
  static final _firestore = FirebaseFirestore.instance;
  static final _postsCollection =
      _firestore.collection(FirebaseCollectionNames.posts);
  static final _usersCollection =
      _firestore.collection(FirebaseCollectionNames.users);

  final List<PostViewModel> posts = [];
  final LikesManager likesManager;

  FavouritePostsRepository(this.likesManager);

  BehaviorSubject<LoadingStateEnum> postsState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);


  Future<List<PostViewModel>> getPosts(userId) async {
    postsState.add(LoadingStateEnum.loading);
    List<DocumentSnapshot> response = [];

    final likes = await getUserPostLikes(userId);

    for (var i in likes) {
      response.add(await _postsCollection.doc(i).get());
    }
    posts.clear();
    // final posts = <PostViewModel>[];
    for (var doc in response) {
      final post = PostModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      final user = await _getUserById(post.creatorId);
      posts.add(PostViewModel(user, post));
    }
    mergeWithLikes(likes);
    postsState.add(LoadingStateEnum.success);
    print(posts.length);
    return posts;
  }

  Future<UserModel> _getUserById(String userId) async {
    final res = await _usersCollection.doc(userId).get();
    return UserModel.fromJson(res.data() as Map<String, dynamic>);
  }

  @override
  PostViewModel? getCachedPost(String postId) {
    for (var i in posts) {
      if (i.postModel.id == postId) return i;
    }

    return null;
  }

  Future<List> getUserPostLikes(String userId) async {
    return likesManager.getUserPostLikes(userId);
  }

  @override
  Future likePost(String postId, String userId) async {
    await likesManager.likePost(postId, userId, posts);
  }

  @override
  List<PostViewModel> mergeWithLikes(List likes) {
    return likesManager.mergeWithLikes(likes, posts);
  }

  @override
  void setPostLiked(String postId, bool value) {
    likesManager.setPostLiked(postId, value, posts);
  }

  @override
  Future unlikePost(String postId, String userId) async {
    await likesManager.unlikePost(postId, userId, posts);
  }
}
