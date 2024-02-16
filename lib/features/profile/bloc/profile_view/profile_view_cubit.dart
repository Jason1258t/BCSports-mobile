import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_view_state.dart';

class ProfileViewCubit extends Cubit<ProfileViewState> {
  final ProfileViewRepository _profileRepository;

  ProfileViewCubit({required ProfileViewRepository profileRepository})
      : _profileRepository = profileRepository,
        super(ViewProfileInitial()) {
    _profileRepository.profileViewState.listen((event) {
      if (event == LoadingStateEnum.loading) emit(ViewProfileLoadingState());
      if (event == LoadingStateEnum.fail) emit(ViewProfileFailState());
      if (event == LoadingStateEnum.success) emit(ViewProfileSuccessState());
      if (event == LoadingStateEnum.wait) emit(ViewProfileLoadingState());
    });
  }
}
