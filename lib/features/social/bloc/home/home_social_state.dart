part of 'home_social_cubit.dart';

@immutable
abstract class HomeSocialState {}

class HomeSocialInitial extends HomeSocialState {}

class HomeSocialLoadingState extends HomeSocialState {}

class HomeSocialSuccessState extends HomeSocialState {}

class HomeSocialFailState extends HomeSocialState {}