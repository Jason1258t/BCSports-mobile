part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final int remain;

  ResetPasswordSuccess(this.remain);
}

class ResetPasswordFail extends ResetPasswordState {}

class ResetWaitState extends ResetPasswordState {
  final int remain;

  ResetWaitState(this.remain);
}
