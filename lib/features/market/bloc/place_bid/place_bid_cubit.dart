import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'place_bid_state.dart';

class PlaceBidCubit extends Cubit<PlaceBidState> {
  final MarketRepository _marketRepository;

  PlaceBidCubit(this._marketRepository) : super(PlaceBidInitial());

  Future<void> updateBid(NftModel nft, double newPrice) async {
    emit(PlaceBidLoading());

    try {
      await _marketRepository.updateNftAuctionPrice(newPrice, nft);
      emit(PlaceBidSuccess());
    } catch (e) {
      emit(PlaceBidSuccess());
    }
  }
}
