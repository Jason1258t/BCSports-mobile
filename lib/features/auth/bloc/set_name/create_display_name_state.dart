part of 'create_display_name_cubit.dart';

@immutable
abstract class CreateDisplayNameState {}

class CreateDisplayNameInitial extends CreateDisplayNameState {}

class CreateLoadingState extends CreateDisplayNameState {}

class CreateSuccessState extends CreateDisplayNameState {}