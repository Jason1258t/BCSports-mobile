import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;

  AppCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(AppInitial()) {
    _authRepository.appState.stream.listen((event) {
      print(event);

      if (event == AppAuthStateEnum.auth) emit(AppAuthState());
      if (event == AppAuthStateEnum.unAuth) emit(AppUnAuthState());
      if (event == AppAuthStateEnum.wait) emit(AppInitial());
      if (event == AppAuthStateEnum.noInternet) emit(NoInternetState());
    });
  }
}
