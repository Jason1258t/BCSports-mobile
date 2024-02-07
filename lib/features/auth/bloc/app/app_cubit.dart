import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final SocialRepository _socialRepository;

  AppCubit(AuthRepository authRepository, ProfileRepository profileRepository, SocialRepository socialRepository)
      : _authRepository = authRepository,
        _profileRepository = profileRepository,
        _socialRepository = socialRepository,
        super(AppInitial()) {
    _authRepository.appState.stream.listen((event) {
      if (event == AppAuthStateEnum.auth) {
        _profileRepository.setUser(_authRepository.currentUser!.uid);
        _socialRepository.initial();
        emit(AppAuthState());
      }
      if (event == AppAuthStateEnum.unAuth) emit(AppUnAuthState());
      if (event == AppAuthStateEnum.wait) emit(AppInitial());
      if (event == AppAuthStateEnum.noInternet) emit(NoInternetState());
    });
  }
}
