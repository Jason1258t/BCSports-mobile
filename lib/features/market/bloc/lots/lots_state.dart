part of 'lots_cubit.dart';

@immutable
sealed class LotsState {}

final class LotsInitial extends LotsState {}

final class LotsSuccess extends LotsState {}

final class LotsFailure extends LotsState {}

final class LotsLoading extends LotsState {}
