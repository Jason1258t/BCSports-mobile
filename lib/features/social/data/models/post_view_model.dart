import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';

class PostViewModel {
  final PostModel postModel;
  final UserModel userModel;

  PostViewModel(this.userModel, this.postModel);
}
