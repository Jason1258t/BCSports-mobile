part of 'delete_post_cubit.dart';

@immutable
abstract class DeletePostState {}

class DeletePostInitial extends DeletePostState {}

class DeleteProcessState extends DeletePostState {
  final String postId;

  DeleteProcessState(this.postId);
}

class DeleteSuccessState extends DeletePostState {
  final String postId;

  DeleteSuccessState(this.postId);
}

class DeleteFailState extends DeletePostState {
  final String postId;

  DeleteFailState(this.postId);
}