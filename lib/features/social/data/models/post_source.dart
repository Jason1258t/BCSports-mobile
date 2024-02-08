import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';

abstract class PostSource {
  PostViewModel? getCachedPost(String postId);

  Future likePost(String postId, String userId);

  Future unlikePost(String postId, String userId);

  void setPostLiked(String postId, bool value);

  List<PostViewModel> mergeWithLikes(List likes);
}
