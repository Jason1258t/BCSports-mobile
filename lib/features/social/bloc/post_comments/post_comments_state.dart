part of 'post_comments_cubit.dart';

@immutable
abstract class PostCommentsState {}

class PostCommentsInitial extends PostCommentsState {}


class PostCommentsLoadingState extends PostCommentsState {}

class PostCommentsSuccessState extends PostCommentsState {}

class PostCommentsFailState extends PostCommentsState {}

class CreatingComment extends PostCommentsState {}

class CommentCreatingState extends PostCommentsState {}

class CommentCreateSuccess extends PostCommentsState {}