part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportFailure extends ReportState {}

final class ReportSuccess extends ReportState {}
