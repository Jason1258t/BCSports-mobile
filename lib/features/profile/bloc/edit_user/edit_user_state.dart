part of 'edit_user_cubit.dart';

@immutable
abstract class EditUserState {}

class EditUserInitial extends EditUserState {}

class EditUserLoadingState extends EditUserState {}

class EditUserSuccessState extends EditUserState {}

class EditUserFailState extends EditUserState {
  final Exception e;

  EditUserFailState(this.e);
}
