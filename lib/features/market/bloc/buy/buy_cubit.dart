import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buy_state.dart';

class BuyNftCubit extends Cubit<BuyNftState> {
  final MarketRepository _marketRepository;
  final ProfileRepository _profileRepository;

  BuyNftCubit(this._profileRepository, this._marketRepository)
      : super(BuyNftInitial());

  Future<void> buyNft(MarketItemModel product) async {
    emit(BuyNftLoading());

    try {
      await _marketRepository.removeProductFromMarket(product);
      await _profileRepository.buyNft(product: product);
      
      emit(BuyNftSuccess());
    } catch (e) {
      emit(BuyNftSuccess());
    }
  }
}
