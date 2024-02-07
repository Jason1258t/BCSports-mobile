import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ProfileRepository _profileRepository;

  UserCubit({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(UserInitial()){
    _profileRepository.profileState.listen((event) {
      if(event == LoadingStateEnum.loading) emit(UserLoadingState());
      if(event == LoadingStateEnum.fail) emit(UserFailState());
      if(event == LoadingStateEnum.success) emit(UserSuccessState());
    });
  }
}
