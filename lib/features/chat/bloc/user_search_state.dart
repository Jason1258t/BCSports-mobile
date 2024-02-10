part of 'user_search_cubit.dart';

@immutable
abstract class UserSearchState {}

class UserSearchInitial extends UserSearchState {}

class UserSearchLoadingState extends UserSearchState {}

class UserSearchSuccess extends UserSearchState {}

class UserSearchFail extends UserSearchState {}