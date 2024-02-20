import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final ProfileRepository _profileRepository;
  final MarketRepository _marketRepository;

  FavouriteCubit(this._profileRepository, this._marketRepository)
      : super(FavouriteInitial());

  Future markAsFavourite(MarketItemModel product) async {
    emit(FavouriteLoading());
    try {
      await _profileRepository.markFavourite(product);
      emit(FavouriteSuccess());
    } catch (e) {
      emit(FavouriteFailure());
    }
  }

  Future removeFromFavourites(MarketItemModel product) async {
    emit(FavouriteLoading());
    try {
      await _profileRepository.removeFromFavourites(product);
      emit(FavouriteSuccess());
    } catch (e) {
      emit(FavouriteFailure());
    }
  }

  List<MarketItemModel> getFavouritesUserList() {
    final List<dynamic> likedNftIdList =
        _profileRepository.user.favouritesNftList;

    final List<MarketItemModel> favouriteNftList = _marketRepository.productList
        .where((product) => likedNftIdList.contains(product.id))
        .toList();

    return favouriteNftList;
  }
}
