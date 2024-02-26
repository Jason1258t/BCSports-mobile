import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  int currentPageIndex = 0;
  int maxPageIndex = 3;

  OnboardingCubit() : super(OnboardingInitial());

  void setPage(int page) {
    currentPageIndex = page;
    emit(OnboardingPageChanged());
  }

  void nextPage() {
    if (currentPageIndex < maxPageIndex) {
      currentPageIndex += 1;
      emit(OnboardingPageChanged());
    }
  }

  void resetStartPageIndex() {
    currentPageIndex = 0;
  }

  void skipAllPages() {
    currentPageIndex = maxPageIndex;
    emit(OnboardingPageChanged());
  }
}
