import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final ProfileRepository _profileRepository;

  FavouriteCubit(this._profileRepository) : super(FavouriteInitial());

  Future markAsFavourite(NftModel nft) async {
    emit(FavouriteLoading());
    try {
      await _profileRepository.markFavourite(nft);
      emit(FavouriteSuccess());
    } catch (e) {
      emit(FavouriteFailure());
    }
  }

  Future removeFromFavourites(NftModel nft) async {
    emit(FavouriteLoading());
    try {
      await _profileRepository.removeFromFavourites(nft);
      emit(FavouriteSuccess());
    } catch (e) {
      emit(FavouriteFailure());
    }
  }
}
