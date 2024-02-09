part of 'user_nft_cubit.dart';

@immutable
sealed class UserNftState {}

final class UserNftInitial extends UserNftState {}

final class UserNftFailure extends UserNftState {}

final class UserNftLoading extends UserNftState {}

final class UserNftSuccess extends UserNftState {}
