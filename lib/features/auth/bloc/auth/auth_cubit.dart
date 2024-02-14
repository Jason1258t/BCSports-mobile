import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(AuthInitial());

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthInProcess());
    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthFailState(e));
    }
  }

  void signInWithGoogle() async {
    emit(AuthInProcess());
    try {
      await _authRepository.signInWithGoogle();
      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthFailState(e));
    }
  }

  void signInWithApple() async {
    emit(AuthInProcess());
    try {
      await _authRepository.signInWithApple();
      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthFailState(e));
      rethrow;
    }
  }

  void signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthInProcess());
    try {
      await _authRepository.registerWithEmailAndPassword(email, password);
      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthFailState(e));
    }
  }

  void signOut() => _authRepository.signOut();

}
