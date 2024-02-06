part of 'create_post_cubit.dart';

@immutable
abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreateLoadingState extends CreatePostState {}

class CreateSuccessState extends CreatePostState {}

class CreateFailState extends CreatePostState {
  final Exception e;

  CreateFailState(this.e);
}
