import 'dart:async';

import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(ResetPasswordInitial());

  int remainingTime = 60;
  static const Duration onSec = Duration(seconds: 1);

  void startTimer() async {
    Timer.periodic(onSec, (timer) {
      if (remainingTime > 1) {
        remainingTime -= 1;
        emit(ResetWaitState(remainingTime));
      } else {
        timer.cancel();
        remainingTime = 60;
      }
    });
  }

  void resetPassword(String email) async {
    emit(ResetPasswordLoadingState());
    try {
      await _authRepository.resetPassword(email);
      startTimer();
      emit(ResetPasswordSuccess(remainingTime));
    } catch (e) {
      emit(ResetPasswordFail());
      rethrow;
    }
  }
}
