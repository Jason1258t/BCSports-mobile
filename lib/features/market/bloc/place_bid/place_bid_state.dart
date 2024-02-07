part of 'place_bid_cubit.dart';

@immutable
sealed class PlaceBidState {}

final class PlaceBidInitial extends PlaceBidState {}

final class PlaceBidLoading extends PlaceBidState {}

final class PlaceBidFail extends PlaceBidState {}

final class PlaceBidSuccess extends PlaceBidState {}
