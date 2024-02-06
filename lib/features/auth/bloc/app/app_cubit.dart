import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  AppCubit(AuthRepository authRepository, ProfileRepository profileRepository)
      : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(AppInitial()) {
    _authRepository.appState.stream.listen((event) {
      print(event);

      if (event == AppAuthStateEnum.auth) {
        _profileRepository.setUser(_authRepository.currentUser!.uid);
        emit(AppAuthState());
      }
      if (event == AppAuthStateEnum.unAuth) emit(AppUnAuthState());
      if (event == AppAuthStateEnum.wait) emit(AppInitial());
      if (event == AppAuthStateEnum.noInternet) emit(NoInternetState());
    });
  }
}
