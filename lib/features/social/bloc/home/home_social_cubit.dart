import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_social_state.dart';

class HomeSocialCubit extends Cubit<HomeSocialState> {
  final SocialRepository _socialRepository;
  final ProfileRepository _profileRepository;

  HomeSocialCubit(
      SocialRepository socialRepository, ProfileRepository profileRepository)
      : _socialRepository = socialRepository,
        _profileRepository = profileRepository,
        super(HomeSocialInitial()) {
    _addListener();
  }

  _addListener() {
    _socialRepository.homeScreenState.stream.listen((event) async {
      if (event == LoadingStateEnum.success) {
        await _socialRepository.getUserPostLikes(_profileRepository.user.id);
        _socialRepository.mergeWithLikes();
        emit(HomeSocialSuccessState());
      }
      if (event == LoadingStateEnum.loading) emit(HomeSocialLoadingState());
      if (event == LoadingStateEnum.fail) emit(HomeSocialFailState());
    });
  }
}
