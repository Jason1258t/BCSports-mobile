import 'package:bcsports_mobile/models/post_model.dart';
import 'package:bcsports_mobile/models/user_model.dart';

class PostViewModel {
  final PostModel postModel;
  final UserModel user;

  String? get imageUrl => postModel.imageUrl;
  String? get compressedImageUrl => postModel.compressedImageUrl;

  String get authorName => user.displayName;
  String get postId => postModel.id;

  PostViewModel(this.user, this.postModel);
}
