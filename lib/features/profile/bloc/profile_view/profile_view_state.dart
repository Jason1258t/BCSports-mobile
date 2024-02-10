part of 'profile_view_cubit.dart';

@immutable
abstract class ProfileViewState {}

class ViewProfileInitial extends ProfileViewState {}

final class ViewProfileFailState extends ProfileViewState {}

final class ViewProfileLoadingState extends ProfileViewState {}

final class ViewProfileSuccessState extends ProfileViewState {}