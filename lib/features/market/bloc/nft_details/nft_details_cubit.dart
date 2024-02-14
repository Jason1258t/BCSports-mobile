import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'nft_details_state.dart';

class NftDetailsCubit extends Cubit<NftDetailsState> {
  final MarketRepository marketRepository;

  NftDetailsCubit(this.marketRepository) : super(NftDetailsInitial());

  Future<void> getNftDetails(NftModel nft) async {
    emit(NftDetailsLoading());
    try {
      await marketRepository.nftService.updateNftViewsCounter(nft.documentId);
      await marketRepository.nftService.loadNftDetailsData(nft.documentId);
      emit(NftDetailsSuccess());
    } catch (e) {
      emit(NftDetailsFailure());
    }
  }
}
