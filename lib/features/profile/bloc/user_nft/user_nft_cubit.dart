import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_nft_state.dart';

class UserNftCubit extends Cubit<UserNftState> {
  final ProfileRepository _profileRepository;

  UserNftCubit(this._profileRepository) : super(UserNftInitial()) {
    _profileRepository.userNftStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(UserNftLoading());
      if (value == LoadingStateEnum.success) emit(UserNftSuccess());
      if (value == LoadingStateEnum.fail) emit(UserNftFailure());
    });
  }
}
