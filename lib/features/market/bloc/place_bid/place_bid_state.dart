part of 'place_bid_cubit.dart';

@immutable
sealed class BuyNftState {}

final class BuyNftInitial extends BuyNftState {}

final class BuyNftLoading extends BuyNftState {}

final class BuyNftFail extends BuyNftState {}

final class BuyNftSuccess extends BuyNftState {}
