part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoading extends FavouriteState {}

final class FavouriteFailure extends FavouriteState {}

final class FavouriteSuccess extends FavouriteState {}
