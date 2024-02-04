import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;

  AppCubit(this._authRepository) : super(AppInitial());
}
