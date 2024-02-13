part of 'market_cubit.dart';

@immutable
sealed class MarketState {}

final class MarketInitial extends MarketState {}

final class MarketLoading extends MarketState {}

final class MarketSuccess extends MarketState {}

final class MarketFailure extends MarketState {}


