import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final MarketRepository marketRepository;

  MarketCubit(this.marketRepository) : super(MarketInitial()) {
    marketRepository.marketStream.listen((event) {
      
    });
  }
}
