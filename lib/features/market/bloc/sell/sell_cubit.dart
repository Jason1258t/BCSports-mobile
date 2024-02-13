import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sell_state.dart';

class SellCubit extends Cubit<SellState> {
  final ProfileRepository profileRepository;

  SellCubit(this.profileRepository) : super(SellInitial());

  void sellNft(NftModel nft) async {
    emit(SellLoading());
    try {
      await profileRepository.sellNft(nft.documentId);
      emit(SellSuccess());
    } catch (e) {
      emit(SellFailure());
    }
  }
}
