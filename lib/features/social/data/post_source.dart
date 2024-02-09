import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class PostSource {
  LikesManager get likesManager;

  BehaviorSubject<LikeChangesData> get likeChanges;

  PostViewModel? getCachedPost(String postId);

  Future likePost(String postId, String userId);

  Future unlikePost(String postId, String userId);

  void setPostLiked(String postId, bool value);

  List<PostViewModel> mergeWithLikes();
}
