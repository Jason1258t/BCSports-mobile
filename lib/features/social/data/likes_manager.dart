import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LikesManager {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static final CollectionReference _users =
      _firestore.collection(FirebaseCollectionNames.users);
  static final CollectionReference _postsCollection =
      _firestore.collection(FirebaseCollectionNames.posts);

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
        if (value) {
          i.postModel.likesCount += 1;
        } else {
          i.postModel.likesCount -= 1;
        }
        return;
      }
    }
  }

  Future<void> _setLikes(
      String postId, String userId, List likes, int count) async {
    await _users
        .doc(userId)
        .set({'postLikes': _postLikes}, SetOptions(merge: true));
    await _postsCollection
        .doc(postId)
        .set({'likesCount': count}, SetOptions(merge: true));
  }

  Future<bool> likePost(
      String postId, String userId, List<PostViewModel> cachedPosts) async {
    if (_postLikes.contains(postId)) return true;

    _postLikes.add(postId);
    try {
      final likesCount =
          getCachedPost(postId, cachedPosts)!.postModel.likesCount;

      await _setLikes(postId, userId, _postLikes, likesCount);

      notifySources(LikeChangesData(true, postId, likesCount));
    } catch (e) {
      _postLikes.remove(postId);
      rethrow;
    }
    mergeWithLikes(cachedPosts);

    return _postLikes.contains(postId);
  }

  Future<bool> unlikePost(
      String postId, String userId, List<PostViewModel> cachedPosts) async {
    if (!_postLikes.contains(postId)) return false;

    _postLikes.remove(postId);
    try {
      final likesCount =
          getCachedPost(postId, cachedPosts)!.postModel.likesCount;

      await _setLikes(postId, userId, _postLikes, likesCount);

      notifySources(LikeChangesData(false, postId, likesCount));
    } catch (e) {
      _postLikes.remove(postId);
    }
    mergeWithLikes(cachedPosts);
    return _postLikes.contains(postId);
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
