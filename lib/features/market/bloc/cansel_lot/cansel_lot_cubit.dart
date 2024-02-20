import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cansel_lot_state.dart';

class CanselLotCubit extends Cubit<CanselLotState> {
  final MarketRepository _marketRepository;
  final ProfileRepository _profileRepository;
  CanselLotCubit(this._marketRepository, this._profileRepository)
      : super(CanselLotInitial());

  Future<void> canselLot(MarketItemModel product) async {
    emit(CanselLotLoading());
    try {
      await _marketRepository.removeProductFromMarket(product);
      await _profileRepository.placeNftIntoInventory(product);
      await _marketRepository.getUserLots();
      emit(CanselLotSuccess());
    } catch (e) {
      emit(CanselLotFailure());
    }
  }
}
