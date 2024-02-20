part of 'favourites_value_cubit.dart';

@immutable
sealed class FavouritesValueState {}

final class FavouritesValueInitial extends FavouritesValueState {}

final class FavouritesValueLoading extends FavouritesValueState {}

final class FavouritesValueSuccess extends FavouritesValueState {}

final class FavouritesValueFailure extends FavouritesValueState {}


