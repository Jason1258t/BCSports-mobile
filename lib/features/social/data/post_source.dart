import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class PostSource {
  LikesManager get likesManager;

  BehaviorSubject<LikeChangesData> get likeChanges;

  List<PostViewModel> get posts;

  PostViewModel? getCachedPost(String postId) {
    for (var i in posts) {
      if (i.postModel.id == postId) return i;
    }
    return null;
  }

  Future likePost(String postId, String userId) =>
      likesManager.likePost(LikeActionData(postId, userId, posts));

  Future unlikePost(String postId, String userId) =>
      likesManager.unlikePost(LikeActionData(postId, userId, posts));

  Future getUserPostLikes(String userId) =>
      likesManager.getUserPostLikes(userId);

  void setPostLiked(String postId, bool value) =>
      likesManager.setPostLiked(postId, value, posts);

  List<PostViewModel> mergeWithLikes() => likesManager.mergeWithLikes(posts);
}
