import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_social_state.dart';

class HomeSocialCubit extends Cubit<HomeSocialState> {
  final SocialRepository _socialRepository;

  HomeSocialCubit(SocialRepository socialRepository)
      : _socialRepository = socialRepository,
        super(HomeSocialInitial()) {
    _socialRepository.homeScreenState.stream.listen((event) {
      if (event == LoadingStateEnum.success) emit(HomeSocialSuccessState());
      if (event == LoadingStateEnum.loading) emit(HomeSocialLoadingState());
      if (event == LoadingStateEnum.fail) emit(HomeSocialFailState());
    });
  }
}
