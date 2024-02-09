import 'package:bcsports_mobile/features/social/data/models/comment_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';

class CommentViewModel {
  final CommentModel _comment;
  final UserModel _user;

  CommentViewModel(this._comment, this._user);

  int get likesCount => _comment.likesCount;

  bool get liked => _comment.liked;

  String get text => _comment.text;

  String get commentId => _comment.id;

  DateTime get createdAt => _comment.createdAt;

  UserModel get user => _user;
}