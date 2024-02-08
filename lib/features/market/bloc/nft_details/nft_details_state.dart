part of 'nft_details_cubit.dart';

@immutable
sealed class NftDetailsState {}

final class NftDetailsInitial extends NftDetailsState {}

final class NftDetailsLoading extends NftDetailsState {}

final class NftDetailsFailure extends NftDetailsState {}

final class NftDetailsSuccess extends NftDetailsState {}

