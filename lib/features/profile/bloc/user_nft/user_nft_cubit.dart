import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_nft_state.dart';

class UserNftCubit extends Cubit<UserNftState> {
  final ProfileRepository _profileRepository;

  UserNftCubit(this._profileRepository) : super(UserNftInitial());

  Future<void> loadUserNft() async {
    emit(UserNftLoading());
    try {
      await _profileRepository.loadUserNftList();
      emit(UserNftSuccess());
    } catch (e) {
      emit(UserNftFailure());
    }
  }
}
