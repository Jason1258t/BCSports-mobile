part of 'sell_cubit.dart';

@immutable
sealed class SellState {}

final class SellInitial extends SellState {}

final class SellLoading extends SellState {}

final class SellFailure extends SellState {}

final class SellSuccess extends SellState {}
