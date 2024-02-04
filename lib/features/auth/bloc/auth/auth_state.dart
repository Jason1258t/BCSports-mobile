part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthInProcess extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailState extends AuthState{
  final Exception e;

  AuthFailState(this.e);
}
