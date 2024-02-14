import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'lots_state.dart';

class LotsCubit extends Cubit<LotsState> {
  final MarketRepository _marketRepository;

  LotsCubit(this._marketRepository) : super(LotsInitial()) {
    _marketRepository.lotsStream.listen((st) {
      if (st == LoadingStateEnum.loading) emit(LotsLoading());
      if (st == LoadingStateEnum.success) emit(LotsSuccess());
      if (st == LoadingStateEnum.fail) emit(LotsFailure());
    });
  }
}
