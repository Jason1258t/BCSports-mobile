import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';

class PostViewModel {
  final PostModel postModel;
  final UserModel user;

  String? get imageUrl => postModel.imageUrl;
  String? get compressedImageUrl => postModel.compressedImageUrl;

  String get authorName => user.displayName ?? user.username;
  String get postId => postModel.id;

  PostViewModel(this.user, this.postModel);
}
