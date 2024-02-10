import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LikesManager {
  static final _users = FirebaseCollections.usersCollection;
  static final _postsCollection = FirebaseCollections.postsCollection;

  final List _postLikes = [];

  final List<PostSource> _postSources = [];

  void addSource(PostSource source) => _postSources.add(source);

  void notifySources(LikeChangesData changeData) {
    for (var source in _postSources) {
      final post = source.getCachedPost(changeData.postId);
      if (post != null) {
        post.postModel.setLike(changeData.value);
        post.postModel.likesCount = changeData.count;
        source.likeChanges.add(changeData);
      }
    }
  }

  Future<List> getUserPostLikes(String userId) async {
    final user = await _users.doc(userId).get();
    _postLikes.clear();
    _postLikes.addAll(((user.data() as Map)['postLikes'] ?? []) as List);
    return _postLikes;
  }

  PostViewModel? getCachedPost(String id, List<PostViewModel> posts) {
    for (var i in posts) {
      if (i.postModel.id == id) return i;
    }
    return null;
  }

  void setPostLiked(postId, value, List<PostViewModel> posts) async {
    for (var i in posts) {
      if (i.postModel.id == postId) {
        i.postModel.setLike(value);
        i.postModel.likesCount += value ? 1 : -1;
        return;
      }
    }
  }

  Future<void> _saveToDatabase(
      String postId, String userId, List likes, int count) async {
    await _users
        .doc(userId)
        .set({'postLikes': _postLikes}, SetOptions(merge: true));
    await _postsCollection
        .doc(postId)
        .set({'likesCount': count}, SetOptions(merge: true));
  }

  Future<void> _updateChanges(LikeActionData data) async {
    final likesCount =
        getCachedPost(data.postId, data.cachedPosts)!.postModel.likesCount;

    await _saveToDatabase(data.postId, data.userId, _postLikes, likesCount);

    notifySources(LikeChangesData(true, data.postId, likesCount));
  }

  Future<bool> likePost(LikeActionData data) async {
    if (_postLikes.contains(data.postId)) return true;

    _postLikes.add(data.postId);
    try {
      await _updateChanges(data);
    } catch (e) {
      _postLikes.remove(data.postId);
      rethrow;
    }

    mergeWithLikes(data.cachedPosts);
    return _postLikes.contains(data.postId);
  }

  Future<bool> unlikePost(LikeActionData data) async {
    if (!_postLikes.contains(data.postId)) return false;

    _postLikes.remove(data.postId);
    try {
      await _updateChanges(data);
    } catch (e) {
      _postLikes.add(data.postId);
    }

    mergeWithLikes(data.cachedPosts);
    return _postLikes.contains(data.postId);
  }

  List<PostViewModel> mergeWithLikes(List<PostViewModel> posts) {
    for (PostViewModel i in posts) {
      if (_postLikes.contains(i.postModel.id)) {
        i.postModel.setLike(true);
      } else {
        i.postModel.setLike(false);
      }
    }

    return posts;
  }
}

class LikeActionData {
  final String postId;
  final String userId;
  final List<PostViewModel> cachedPosts;

  LikeActionData(this.postId, this.userId, this.cachedPosts);
}
