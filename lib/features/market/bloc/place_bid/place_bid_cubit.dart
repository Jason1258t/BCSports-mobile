import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'place_bid_state.dart';

class BuyNftCubit extends Cubit<BuyNftState> {
  // final MarketRepository _marketRepository;
  final ProfileRepository _profileRepository;

  BuyNftCubit(this._profileRepository) : super(BuyNftInitial());

  Future<void> buyNft(NftModel nft) async {
    emit(BuyNftLoading());

    try {
      await _profileRepository.buyNft(nftForBuy: nft);
      emit(BuyNftSuccess());
    } catch (e) {
      emit(BuyNftSuccess());
    }
  }
}
