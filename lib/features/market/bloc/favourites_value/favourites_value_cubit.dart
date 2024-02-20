import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favourites_value_state.dart';

class FavouritesValueCubit extends Cubit<FavouritesValueState> {
  final MarketRepository _marketRepository;

  FavouritesValueCubit(this._marketRepository)
      : super(FavouritesValueInitial()) {
    _marketRepository.favouritesValueStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(FavouritesValueLoading());
      if (value == LoadingStateEnum.fail) emit(FavouritesValueFailure());
      if (value == LoadingStateEnum.success) emit(FavouritesValueSuccess());
    });
  }

  void incrementFavouriteValue() {
    _marketRepository.lastProductFavouritesValue += 1;
    emit(FavouritesValueSuccess());
  }

  void decrementFavouriteValue() {
    _marketRepository.lastProductFavouritesValue -= 1;
    emit(FavouritesValueSuccess());
  }
}
