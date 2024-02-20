part of 'cansel_lot_cubit.dart';

@immutable
sealed class CanselLotState {}

final class CanselLotInitial extends CanselLotState {}

final class CanselLotLoading extends CanselLotState {}

final class CanselLotFailure extends CanselLotState {}

final class CanselLotSuccess extends CanselLotState {}



