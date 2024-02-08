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
        final likes = await _socialRepository
            .getUserPostLikes(_profileRepository.user.id);
        _socialRepository.mergeWithLikes(likes);
        emit(HomeSocialSuccessState());
      }
      if (event == LoadingStateEnum.loading) emit(HomeSocialLoadingState());
      if (event == LoadingStateEnum.fail) emit(HomeSocialFailState());
    });
  }

  void changePostLiked(String postId, bool value) =>
      _socialRepository.setPostLiked(postId, value);

  Future<bool> likePost(String postId) async {
    final user = _profileRepository.user;
    return _socialRepository.likePost(postId, user.id);
  }

  Future<bool> unlikePost(String postId) async {
    final user = _profileRepository.user;
    return _socialRepository.unlikePost(postId, user.id);
  }
}
