import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(ResetPasswordInitial());

  void resetPassword(String email) async {
    emit(ResetPasswordLoadingState());
    try {
      await _authRepository.resetPassword(email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFail());
      rethrow;
    }
  }
}
